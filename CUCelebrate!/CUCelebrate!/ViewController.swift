//
//  ViewController.swift
//  CUCelebrate!
//
//  Created by Aliva Das on 4/24/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

protocol ChangeMyEventDelegate: class {
    func MyEventChanged(to e: Event, newIsMyEventChanged: Bool)
}

class ViewController: UIViewController {

    var featuredCollectionView: UICollectionView!
    var featuredCollectionViewDelgate: EventCollectionViewDelegate!
    var featuredCollectionViewDataSource: EventCollectionViewDataSource!

    var myEventsCollectionView: UICollectionView!
    var myEventsCollectionViewDelegate: EventCollectionViewDelegate!
    var myEventsCollectionViewDataSource: EventCollectionViewDataSource!

    var featuredEvents: [Event]!
    var myEvents: [Event]!
    var tempMyEvents: [Event]!
    var featuredLabel: UILabel!
    var myLabel: UILabel!
    var searchBar: UISearchBar!

    let FEATURED_REUSE_ID = "featuredEventsCellReuseIdentifier"
    let MY_EVENTS_REUSE_ID = "myEventsCellReuseIdentifier"

    let padding: CGFloat = 5
    let myHeight = 200

    weak var delegate: ChangeMyEventDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "CUCelebrate!"

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "back1")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)

        let cellSize = (view.safeAreaLayoutGuide.layoutFrame.width - 20)

        let e1 = Event(eventName: "CU Downtown", eventDate: "Sep 1, 2018", eventTime: "1 PM EDT", eventVenue: "Downtown Ithaca, NY", description: "A free and exciting way to explore the culture of Downtown Ithaca, with dances and songs and food!!", image: UIImage(named: "e1")!)
        let e2 = Event(eventName: "Dragon Day 2019", eventDate: "Mar 29, 2019", eventTime: "12 PM EDT", eventVenue: "Arts Quad", description: "Come see the dragon and the phoenix parade around campus!!" , image: UIImage(named: "e2")!)
        let e3 = Event(eventName: "CIS Formal: Party at Gatsby's", eventDate: "Apr 27, 2019", eventTime: "9 PM EDT", eventVenue: "The Statler Hotel", description: "Join ACSU, WICC and URMC to celebrate the end of the semester with a Gatsby themed formal at the Statler Hotel! It will be a fun filled night with friends, food, dancing and more!!" + "\n" + "Suggested Attire: Semi-Formal" + "\n" + "Tickets are $15 each." , image: UIImage(named: "e3")!)
        let e4 = Event(eventName: "Cornell Chamber Orchestra Concert", eventDate: "Apr 26, 2019", eventTime: "7 PM EDT", eventVenue: "Barnes Hall", description: "We will by playing music by Drdla, Bach, Grieg, Holst as well as compositions by students. This event is free and open to the public! We look forward to seeing you there!" , image: UIImage(named: "e4")!)
        let e5 = Event(eventName: "Mock Shaadi 2019", eventDate: "Apr 26, 2019", eventTime: "8 PM EDT", eventVenue: "Biotech G10", description: "Hosted by Cornell University's South Asian Council." + "\n" + "It’s shaadi season! SAC’s Mock Shaadi is an annual interfaith and intercultural mock wedding celebration that showcases and celebrates that richness and diversity of South Asian cultural and religious wedding traditions. Come through for a night filled with delicious food, music, and dancing!" , image: UIImage(named: "e5")!)

        featuredEvents = [e1,e2,e3,e4,e5]
        myEvents = []

        for event in featuredEvents{
            if(event.isMyEvent == true){
                myEvents.append(event)
            }
        }

        featuredCollectionViewDelgate = EventCollectionViewDelegate(events: featuredEvents, reuseIdentifier: FEATURED_REUSE_ID, view: self)
        featuredCollectionViewDataSource = EventCollectionViewDataSource(events: featuredEvents, reuseIdentifier: FEATURED_REUSE_ID)

        // featured events collection layout
        let featuredLayout = UICollectionViewFlowLayout()
        featuredLayout.scrollDirection = .vertical
        featuredLayout.minimumInteritemSpacing = Constants.padding
        featuredLayout.minimumLineSpacing = Constants.padding*2
        featuredLayout.itemSize = CGSize(width: cellSize, height: 0.5*cellSize)

        // featured events collection view
        featuredCollectionView = UICollectionView(frame: .zero, collectionViewLayout: featuredLayout)
        featuredCollectionView.translatesAutoresizingMaskIntoConstraints = false
        featuredCollectionView.backgroundColor = Constants.backgroundColor
        featuredCollectionView.dataSource = featuredCollectionViewDataSource
        featuredCollectionView.delegate = featuredCollectionViewDelgate
        featuredCollectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: FEATURED_REUSE_ID)

        view.addSubview(featuredCollectionView)

        myEventsCollectionViewDelegate = EventCollectionViewDelegate(events: myEvents, reuseIdentifier: MY_EVENTS_REUSE_ID, view: self)
        myEventsCollectionViewDataSource = EventCollectionViewDataSource(events: myEvents, reuseIdentifier: MY_EVENTS_REUSE_ID)

        // my events collection layout
        let myLayout = UICollectionViewFlowLayout()
        myLayout.scrollDirection = .horizontal
        myLayout.minimumInteritemSpacing = Constants.padding
        myLayout.minimumLineSpacing = Constants.padding
        myLayout.itemSize = CGSize(width: cellSize, height: 0.5*cellSize)

        // featured events collection layout
        myEventsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: myLayout)
        myEventsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        myEventsCollectionView.backgroundColor = Constants.backgroundColor
        myEventsCollectionView.dataSource = myEventsCollectionViewDataSource
        myEventsCollectionView.delegate = myEventsCollectionViewDelegate
        myEventsCollectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: MY_EVENTS_REUSE_ID)
        view.addSubview(myEventsCollectionView)

        featuredLabel = UILabel()
        featuredLabel.translatesAutoresizingMaskIntoConstraints = false
        featuredLabel.text = "Featured Events"
        featuredLabel.textAlignment = .center
        featuredLabel.font = Constants.titleFont
        featuredLabel.textColor = Constants.titleTextColor
        view.addSubview(featuredLabel)

        myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.text = "My Events"
        myLabel.textAlignment = .center
        myLabel.font = Constants.titleFont
        myLabel.textColor = Constants.titleTextColor
        view.addSubview(myLabel)

        //searchBar not yet implemented
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Find an Event"
        searchBar.layer.cornerRadius = 10
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .white
        //searchBar.delegate = self
        view.addSubview(searchBar)

        setupConstraints()
        getOnlineEvents()
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
            myEventsCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(myHeight))
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
            searchBar.heightAnchor.constraint(equalToConstant: 40)
            ])

        NSLayoutConstraint.activate([
            featuredCollectionView.topAnchor.constraint(equalTo: featuredLabel.bottomAnchor, constant: 10),
            featuredCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            featuredCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            featuredCollectionView.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -10)
            ])

    }

    func presentAlert(title: String, desc: String) {
        let alert = UIAlertController(title: title, message: desc, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func getOnlineEvents() {
        NetworkManager.getAllEvents { eventsArray in
            self.featuredEvents = eventsArray
            DispatchQueue.main.async {
                self.featuredCollectionView.reloadData()
            }
        }
    }
    
}

extension ViewController: ChangeMyEventDelegate{
    func MyEventChanged(to e: Event, newIsMyEventChanged: Bool) {
        e.isMyEvent = newIsMyEventChanged
        myEvents = []
        for event in featuredEvents{
            if(event.isMyEvent == true){
                myEvents.append(event)
            }
        }
        myEventsCollectionViewDataSource.setEvents(myEvents)
        myEventsCollectionViewDelegate.setEvents(myEvents)
        myEventsCollectionView.reloadData()
    }

}
