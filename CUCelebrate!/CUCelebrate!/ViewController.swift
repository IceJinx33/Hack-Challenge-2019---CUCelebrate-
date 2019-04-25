//
//  ViewController.swift
//  CUCelebrate!
//
//  Created by Aliva Das on 4/24/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var featuredCollectionView: UICollectionView!
    var featuredCollectionViewDelgate: EventCollectionViewDelegate!
    var featuredCollectionViewDataSource: EventCollectionViewDataSource!
    
    var myEventsCollectionView: UICollectionView!
    var myEventsCollectionViewDelegate: EventCollectionViewDelegate!
    var myEventsCollectionViewDataSource: EventCollectionViewDataSource!
    
    var featuredEvents: [Event]!
    var myEvents: [Event]!
    var featuredLabel: UILabel!
    var myLabel: UILabel!
    var searchBar: UISearchBar!
    
    let FEATURED_REUSE_ID = "featuredEventsCellReuseIdentifier"
    let MY_EVENTS_REUSE_ID = "myEventsCellReuseIdentifier"
    
    let padding: CGFloat = 5
    let myFeaturesHeight = 150

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Events"
        view.backgroundColor = .lightGray
        
        let e1 = Event(eventName: "CU Downtown", eventDate: "Sep 1, 2018", eventTime: "1 PM EDT", eventVenue: "Downtown Ithaca NY", description: "A free and exciting way to explore the culture of Downtown Ithaca, with dances and songs and food!!" ,isMyEvent: true, image: UIImage(named: "e1")!)
        let e2 = Event(eventName: "Dragon Day 2019", eventDate: "Mar 29, 2019", eventTime: "12 PM EDT", eventVenue: "Arts Quad", description: "Come see the dragon and the phoenix parade around campus!!" , image: UIImage(named: "e2")!)
        
        featuredEvents = [e1,e2]
        myEvents = []
        
        for e in featuredEvents{
            if(e.isMyEvent){
                  myEvents.append(e)
            }
        }
        
        featuredCollectionViewDelgate = EventCollectionViewDelegate()
        featuredCollectionViewDataSource = EventCollectionViewDataSource(events: featuredEvents, reuseIdentifier: FEATURED_REUSE_ID)
        
        // featured events collection layout
        let featuredLayout = UICollectionViewFlowLayout()
        featuredLayout.scrollDirection = .vertical
        featuredLayout.minimumInteritemSpacing = padding
        featuredLayout.minimumLineSpacing = padding*2
        
        // featured events collection view
        featuredCollectionView = UICollectionView(frame: .zero, collectionViewLayout: featuredLayout)
        featuredCollectionView.translatesAutoresizingMaskIntoConstraints = false
        featuredCollectionView.backgroundColor = .lightGray
        featuredCollectionView.dataSource = featuredCollectionViewDataSource
        featuredCollectionView.delegate = featuredCollectionViewDelgate
        featuredCollectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: FEATURED_REUSE_ID)
        view.addSubview(featuredCollectionView)
        
        // my events collection layout
        let myLayout = UICollectionViewFlowLayout()
        myLayout.scrollDirection = .horizontal
        myLayout.minimumInteritemSpacing = padding
        myLayout.minimumLineSpacing = padding
        
        // featured events collection layout
        myEventsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: myLayout)
        myEventsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myEventsCollectionView.backgroundColor = .lightGray
        myEventsCollectionView.dataSource = myEventsCollectionViewDataSource
        myEventsCollectionView.delegate = myEventsCollectionViewDelegate
        myEventsCollectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: MY_EVENTS_REUSE_ID)
        view.addSubview(myEventsCollectionView)
        
        featuredLabel = UILabel()
        featuredLabel.translatesAutoresizingMaskIntoConstraints = false
        featuredLabel.text = "Featured Events"
        featuredLabel.textAlignment = .center
        featuredLabel.font = UIFont(name: "Copperplate-Light", size: 20)
        featuredLabel.textColor = .black
        view.addSubview(featuredLabel)
        
        myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.text = "My Events"
        myLabel.textAlignment = .center
        myLabel.font = UIFont(name: "Copperplate-Light", size: 20)
        myLabel.textColor = .black
        view.addSubview(myLabel)
        
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Find an Event"
        //searchBar.delegate = self
        view.addSubview(searchBar)
        
        setupConstraints()
    }

    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            myLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myLabel.widthAnchor.constraint(equalToConstant: 300),
            myLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            myEventsCollectionView.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 10),
            myEventsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            myEventsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            myEventsCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(myFeaturesHeight))
            ])
        
        NSLayoutConstraint.activate([
            featuredLabel.topAnchor.constraint(equalTo: myEventsCollectionView.bottomAnchor, constant: 10),
            featuredLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            featuredLabel.widthAnchor.constraint(equalToConstant: 300),
            featuredLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            searchBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.widthAnchor.constraint(equalToConstant: 300),
            searchBar.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        NSLayoutConstraint.activate([
            featuredCollectionView.topAnchor.constraint(equalTo: myEventsCollectionView.bottomAnchor, constant: 10),
            featuredCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            featuredCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            featuredCollectionView.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -10)
            ])
        
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.featuredCollectionView{
            let length = (collectionView.frame.width - 3*padding)/2.0
            return CGSize(width: length, height: length)
        }
        let length = (collectionView.frame.width - 4*padding)/3.0
        return CGSize(width: length, height: CGFloat(myFeaturesHeight))
    }
    
}




