//
//  ViewController.swift
//  CUCelebrate!
//
//  Created by Aliva Das on 4/24/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

protocol ChangeMyEventDelegate: class {
    func MyEventChanged(to e: Event)
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
    var featuredLabel: UILabel!
    var myLabel: UILabel!
    var searchBar: UISearchBar!
    
    let FEATURED_REUSE_ID = "featuredEventsCellReuseIdentifier"
    let MY_EVENTS_REUSE_ID = "myEventsCellReuseIdentifier"
    
    let myHeight = 200

    weak var delegate: ChangeMyEventDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Events"
        view.backgroundColor = Constants.backgroundColor
        
        let cellSize = (view.safeAreaLayoutGuide.layoutFrame.width - 20)
        
        let e1 = Event(eventName: "CU Downtown",
                       eventDate: "Sep 1, 2018",
                       eventTime: "1 PM EDT",
                       eventVenue: "Downtown Ithaca NY",
                       description: "A free and exciting way to explore the culture of Downtown Ithaca, with dances and songs and food!!",
                       image: UIImage(named: "e1")!)
        let e2 = Event(eventName: "Dragon Day 2019",
                       eventDate: "Mar 29, 2019",
                       eventTime: "12 PM EDT",
                       eventVenue: "Arts Quad",
                       description: "Come see the dragon and the phoenix parade around campus!!",
                       image: UIImage(named: "e2")!)
        
        featuredEvents = [e1,e2, Constants.placeholderEvent]
        myEvents = [Constants.placeholderEvent]
     
        for e in featuredEvents{
            if(e.isMyEvent){
                myEvents.append(e)
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
        
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Find an Event"
        searchBar.layer.cornerRadius = 10
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .white
        searchBar.delegate = self
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
}

extension ViewController: ChangeMyEventDelegate{
    func MyEventChanged(to e: Event) {
        viewDidLoad()
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            let data = NetworkManager.getResultsFromQuery(query: Query(text: searchText, type: .name))
            if data.count == 0 {
                presentAlert(title: "No Results Found", desc: "Sorry, we couldn't find any results. Try changing your search keywords.")
            } else {
            self.navigationController?.pushViewController(SearchResultViewController(data: data), animated: true)
            }
            
        } else {
            presentAlert(title: "No Search Terms Entered", desc: "Please enter the name of the event you are searching for.")
        }
        
        
    }
}
