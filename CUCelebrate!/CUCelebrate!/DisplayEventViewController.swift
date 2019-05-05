//
//  DisplayEventViewController.swift
//  CUCelebrate!
//
//  Created by Aliva Das on 4/25/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit
import Alamofire

class DisplayEventViewController: UIViewController {

    var name: UILabel!
    var date: UILabel!
    var time: UILabel!
    var venue: UILabel!
    var checkLabel: UILabel!
    var descText: UITextView!
    var image: UIImageView!
    var timeIcon: UIImageView!
    var mapIcon: UIImageView!
    var mapButton: UIButton!
    var checkButton: UIButton!
    var barButton: UIBarButtonItem!

    weak var delegate: ChangeMyEventDelegate?

    var placeholderEvent: Event!

    init(placeholderEvent: Event) {
        self.placeholderEvent = placeholderEvent
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let darkPink = UIColor(red: 0.9176, green: 0.2667, blue: 0.3647, alpha: 1.0)
    let coral = UIColor(red: 0.8275, green: 0.2314, blue: 0.2392, alpha: 1.0)
    let pink = UIColor(red: 1, green: 0.3882, blue: 0.4902, alpha: 1.0)
    let lightPink = UIColor(red: 1, green: 0.4863, blue: 0.6667, alpha: 1.0)
    let gold = UIColor(red: 0.9, green: 0.5, blue: 0, alpha: 1.0)
    let orange = UIColor(red: 1, green: 0.4784, blue: 0.2863, alpha: 1.0)
    
    let mapURL: String = "https://www.google.com/maps/search/?api=1&query="

    override func viewDidLoad() {
        super.viewDidLoad()

         // Do any additional setup after loading the view.
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.red.cgColor, darkPink.cgColor, coral.cgColor, pink.cgColor, orange.cgColor, orange.cgColor, pink.cgColor, darkPink.cgColor, coral.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)

        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = placeholderEvent.eventName
        name.textColor = .black
        name.textAlignment = .center
        name.adjustsFontSizeToFitWidth = true
        name.minimumScaleFactor = 10
        name.font = Constants.eventTitleFont
        view.addSubview(name)

        date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.text = placeholderEvent.eventDate
        date.textColor = .white
        date.adjustsFontSizeToFitWidth = true
        date.minimumScaleFactor = 10
        date.font = Constants.infoLabelFont
        view.addSubview(date)

        time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.text = placeholderEvent.eventTime
        time.textColor = .white
        time.adjustsFontSizeToFitWidth = true
        time.minimumScaleFactor = 10
        time.font = Constants.infoLabelFont
        view.addSubview(time)

        venue = UILabel()
        venue.translatesAutoresizingMaskIntoConstraints = false
        venue.text = placeholderEvent.eventVenue
        venue.textColor = .white
        venue.adjustsFontSizeToFitWidth = true
        venue.minimumScaleFactor = 10
        venue.font = Constants.infoLabelFont
        view.addSubview(venue)

        checkLabel = UILabel()
        checkLabel.translatesAutoresizingMaskIntoConstraints = false
        checkLabel.text = "Add to My Events"
        checkLabel.font = Constants.infoLabelFont
        view.addSubview(checkLabel)

        descText = UITextView()
        descText.translatesAutoresizingMaskIntoConstraints = false
        descText.text = placeholderEvent.description
        descText.textColor = .white
        descText.backgroundColor = .clear
        descText.font = Constants.infoLabelFont
        descText.isEditable = false
        view.addSubview(descText)

        image = UIImageView(image: placeholderEvent.image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.isHidden = false
        image.layer.cornerRadius = 10
        image.backgroundColor = .clear
        image.layer.borderWidth = 2.0
        image.layer.borderColor = UIColor.clear.cgColor
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        view.addSubview(image)

        timeIcon = UIImageView(image: UIImage(named: "clock"))
        timeIcon.translatesAutoresizingMaskIntoConstraints = false
        timeIcon.contentMode = .scaleAspectFit
        timeIcon.isHidden = false
        view.addSubview(timeIcon)

        mapIcon = UIImageView(image: UIImage(named: "map"))
        mapIcon.translatesAutoresizingMaskIntoConstraints = false
        mapIcon.contentMode = .scaleAspectFit
        mapIcon.isHidden = false
        view.addSubview(mapIcon)

        mapButton = UIButton()
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        mapButton.setTitle("Find Location on Map", for: .normal)
        mapButton.setTitleColor(.black, for: .normal)
        mapButton.addTarget(self, action: #selector(findLocation), for: .touchUpInside)
        view.addSubview(mapButton)

        checkButton = UIButton()
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.backgroundColor = .white
        checkButton.setBackgroundImage(UIImage(named: "check"), for: .selected)
        if(placeholderEvent.isMyEvent == true){
            checkButton.isSelected = true
        }
        checkButton.layer.borderWidth = 2
        checkButton.layer.borderColor = UIColor.black.cgColor
        checkButton.setBackgroundImage(UIImage(named: "check"), for: .selected)
        checkButton.addTarget(self, action: #selector(checkBox), for: .touchUpInside)
        view.addSubview(checkButton)

        barButton = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveWork))
        barButton.title = "Save"
        navigationItem.setRightBarButton(barButton, animated: true)

        setupConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            image.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.height/3.0)
            ])

        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            name.heightAnchor.constraint(equalToConstant: Constants.eventTitleHeight)
            ])

        NSLayoutConstraint.activate([
            timeIcon.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 25),
            timeIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            timeIcon.widthAnchor.constraint(equalToConstant: 2 * Constants.eventTitleHeight),
            timeIcon.heightAnchor.constraint(equalToConstant: 2 * Constants.eventTitleHeight)
            ])

        NSLayoutConstraint.activate([
            date.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            date.leadingAnchor.constraint(equalTo: timeIcon.trailingAnchor, constant: 20),
            date.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            date.heightAnchor.constraint(equalToConstant: Constants.eventTitleHeight)
            ])

        NSLayoutConstraint.activate([
            time.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 10),
            time.leadingAnchor.constraint(equalTo: timeIcon.trailingAnchor, constant: 20),
            time.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            time.heightAnchor.constraint(equalToConstant: Constants.eventTitleHeight)
            ])

        NSLayoutConstraint.activate([
            mapIcon.topAnchor.constraint(equalTo: time.bottomAnchor, constant: 10),
            mapIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mapIcon.widthAnchor.constraint(equalToConstant: 2 * Constants.eventTitleHeight),
            mapIcon.heightAnchor.constraint(equalToConstant: 2 * Constants.eventTitleHeight)
            ])

        NSLayoutConstraint.activate([
            venue.topAnchor.constraint(equalTo: time.bottomAnchor, constant: 20),
            venue.leadingAnchor.constraint(equalTo: mapIcon.trailingAnchor, constant: 20),
            venue.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            venue.heightAnchor.constraint(equalToConstant: Constants.eventTitleHeight)
            ])

        NSLayoutConstraint.activate([
            mapButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            mapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapButton.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width*2/3.0),
            mapButton.heightAnchor.constraint(equalToConstant: Constants.eventTitleHeight)
            ])

        NSLayoutConstraint.activate([
            checkButton.bottomAnchor.constraint(equalTo: mapButton.topAnchor, constant: -20),
            checkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            checkButton.widthAnchor.constraint(equalToConstant: 2 * Constants.eventTitleHeight),
            checkButton.heightAnchor.constraint(equalToConstant: 2 * Constants.eventTitleHeight)
            ])

        NSLayoutConstraint.activate([
            checkLabel.bottomAnchor.constraint(equalTo: mapButton.topAnchor, constant: -30),
            checkLabel.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 20),
            checkLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            checkLabel.heightAnchor.constraint(equalToConstant: Constants.eventTitleHeight)
            ])

        NSLayoutConstraint.activate([
            descText.topAnchor.constraint(equalTo: venue.bottomAnchor, constant: 20),
            descText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descText.bottomAnchor.constraint(equalTo: checkLabel.topAnchor, constant: -20),
            ])
    }

    @objc func checkBox(){
        checkButton.isSelected = !checkButton.isSelected
        placeholderEvent.isMyEvent = !placeholderEvent.isMyEvent
    }

    @objc func saveWork(){
        delegate?.MyEventChanged(to: placeholderEvent, newIsMyEventChanged: placeholderEvent.isMyEvent)
        navigationController?.popViewController(animated: true)
       // NetworkManager.updateEvent(user: "User", event: placeholderEvent)
    }
    
    func encodeURL(venue: String) -> String{
        var place: String = ""
        for x in venue{
            if(x==" "){
                place = place + "+"
            }
            if(x==","){
                place = place + "%20"
            }
            else{
                place = place + String(x)
            }
        }
        place = place.replacingOccurrences(of: " ", with: "")
        return mapURL+place
    }
    
    @objc func findLocation(){
        if let urlComponents = URLComponents (string: encodeURL(venue: placeholderEvent.eventVenue) ){
            UIApplication.shared.open (urlComponents.url!)
        }
        else{
            let alert = UIAlertController(title: "Server Error", message: "The server is unable to process the URL request at this moment.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
