//
//  EventCollectionViewDelegate.swift
//  CUCelebrate!
//
//  Created by Admin on 4/24/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

class EventCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    // choosing private access here to force encapsulation
    // Use setEvents(_:) and getEvents() to set and get the event array.
    
    private var events: [Event]
    private var reuseIdentifier: String
    private var view: ViewController
    private var cellHeight: CGFloat = 200
    
    init(events: [Event], reuseIdentifier: String, view: ViewController) {
        self.events = events
        self.reuseIdentifier = reuseIdentifier
        self.view = view
    }
    
    func setEvents(_ newEvents: [Event]){
        events = newEvents
    }
    
    func getReuseIdentifier() -> String { return reuseIdentifier }
    
    func getEvents() -> [Event] { return events }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = events[indexPath.row]
        let navViewController = DisplayEventViewController(placeholderEvent: event)
        navViewController.delegate = view
        view.navigationController?.pushViewController(navViewController, animated: true)
    }
    
}
