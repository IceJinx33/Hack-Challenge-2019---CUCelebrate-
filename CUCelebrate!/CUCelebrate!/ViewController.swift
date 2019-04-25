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
    var myEventsCollectionView: UICollectionView!
    var featuredEventsArray: [Event]!
    var myEventsArray: [Event]!
    var featuredLabel: UILabel!
    var myLabel: UILabel!
    var searchBar: UISearchBar!
    
    let featuredEventsCellReuseIdentifier = "featuredEventsCellReuseIdentifier"
    let myEventsCellReuseIdentifier = "myEventsCellReuseIdentifier"
    
    let padding: CGFloat = 5
    let myFeaturesHeight = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Events"
        view.backgroundColor = .lightGray
        
        let e1 = Event(eventName: "CU Downtown", eventDate: "Sep 1, 2018", eventTime: "1 PM EDT", eventVenue: "Downtown Ithaca NY", description: "A free and exciting way to explore the culture of Downtown Ithaca, with dances and songs and food!!" ,isMyEvent: true, image: UIImage(named: "e1")!)
        let e2 = Event(eventName: "Dragon Day 2019", eventDate: "Mar 29, 2019", eventTime: "12 PM EDT", eventVenue: "Arts Quad", description: "Come see the dragon and the phoenix parade around campus!!" , image: UIImage(named: "e2")!)
        
        featuredEventsArray = [e1,e2]
        
        for e in featuredEventsArray{
            if(e.isMyEvent == true){
                  myEventsArray.append(e)
            }
        }
        
        let featuredLayout = UICollectionViewFlowLayout()
        featuredLayout.scrollDirection = .vertical
        featuredLayout.minimumInteritemSpacing = padding
        featuredLayout.minimumLineSpacing = padding*2
        featuredCollectionView = UICollectionView(frame: .zero, collectionViewLayout: featuredLayout)
        featuredCollectionView.translatesAutoresizingMaskIntoConstraints = false
        featuredCollectionView.backgroundColor = .lightGray
        featuredCollectionView.dataSource = self
        featuredCollectionView.delegate = self
        featuredCollectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: featuredEventsCellReuseIdentifier)
        view.addSubview(featuredCollectionView)
        
        let myLayout = UICollectionViewFlowLayout()
        myLayout.scrollDirection = .horizontal
        myLayout.minimumInteritemSpacing = padding
        myLayout.minimumLineSpacing = padding
        myEventsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: filterLayout)
        myEventsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myEventsCollectionView.backgroundColor = .lightGray
        myEventsCollectionView.dataSource = self
        myEventsCollectionView.delegate = self
        myEventsCollectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: myEventsCellReuseIdentifier)
        view.addSubview(myEventsCollectionView)
        
        setupConstraints()
    }


}

