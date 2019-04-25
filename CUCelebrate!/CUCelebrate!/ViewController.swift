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
    let myFeaturesHeight = 40

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Events"
        view.backgroundColor = .lightGray
        
        let e1 = Event(eventName: "CU Downtown", eventDate: "Sep 1, 2018", eventTime: "1 PM EDT", eventVenue: "Downtown Ithaca NY", description: "A free and exciting way to explore the culture of Downtown Ithaca, with dances and songs and food!!" ,isMyEvent: true, image: UIImage(named: "e1")!)
        let e2 = Event(eventName: "Dragon Day 2019", eventDate: "Mar 29, 2019", eventTime: "12 PM EDT", eventVenue: "Arts Quad", description: "Come see the dragon and the phoenix parade around campus!!" , image: UIImage(named: "e2")!)
        
        featuredEvents = [e1,e2]
        
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
        
        setupConstraints()
    }

    func setupConstraints() {
        
        // TODO implement
        
    }

}

