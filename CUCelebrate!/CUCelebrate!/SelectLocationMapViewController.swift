//
//  SelectLocationMapViewController.swift
//  CUCelebrate!
//
//  Created by Pinxuan Huang on 4/26/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

// Work in progress - this view should allow the user to select a location by dragging the map around.

class SelectLocationMapViewController: ViewController {

    var mapView: MKMapView!
    var addressLabel: UILabel!
    var pinImageView: UIImageView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 100 //00
    var previousLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Location"
        view.backgroundColor = .purple //.lightGray
        
        mapView = MKMapView()
        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = 20
        let mapWidth:CGFloat = view.frame.size.width
        let mapHeight:CGFloat = view.frame.size.height - 50
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.center = view.center
        view.addSubview(mapView)
        
        addressLabel = UILabel()
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.text = ""
        addressLabel.textAlignment = .center
        addressLabel.font = UIFont(name: "Copperplate-Light", size: 20)
        addressLabel.textColor = .black
        view.addSubview(addressLabel)
        
        pinImageView = UIImageView()
        pinImageView.translatesAutoresizingMaskIntoConstraints = false
        let pinImage: UIImage = UIImage(named: "pin")!
        pinImageView = UIImageView(image: pinImage)
        pinImageView.contentMode = .scaleAspectFit
        pinImageView.isHidden = false
        pinImageView.clipsToBounds = true
        view.addSubview(pinImageView)
        
        setupConstraints()
        checkLocationServices()
    }
    
    override func setupConstraints() {
        
        NSLayoutConstraint.activate([
            pinImageView.heightAnchor.constraint(equalToConstant: 40),
            pinImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pinImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pinImageView.widthAnchor.constraint(equalToConstant: 40)
            ])
        
        NSLayoutConstraint.activate([
            addressLabel.heightAnchor.constraint(equalToConstant: 36),
            addressLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            addressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addressLabel.widthAnchor.constraint(equalToConstant: view.frame.width)
            ])
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTackingUserLocation()
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        }
    }
    
    
    func startTackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}


extension SelectLocationMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}


extension SelectLocationMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                //TODO: Show alert informing the user
                return
            }
            
            guard let placemark = placemarks?.first else {
                //TODO: Show alert informing the user
                return
            }
            
            //            let streetNumber = placemark.subThoroughfare ?? ""
            //            let streetName = placemark.thoroughfare ?? ""
            let placeName = placemark.name ?? ""
            let subLoc = placemark.subLocality ?? ""
            let loc = placemark.locality ?? ""
            let subArea = placemark.subAdministrativeArea ?? ""
            
            DispatchQueue.main.async {
                self.addressLabel.text = "\(subLoc)"
                //                self.addressLabel.text = "\(streetNumber) \(streetName)"
            }
        }
    }
}
