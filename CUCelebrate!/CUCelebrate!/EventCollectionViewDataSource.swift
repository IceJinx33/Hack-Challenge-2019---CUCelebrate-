//
//  EventCollectionViewDataSource.swift
//  CUCelebrate!
//
//  Created by Admin on 4/24/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import UIKit

class EventCollectionViewDataSource: NSObject , UICollectionViewDataSource {
    
    // choosing private access here to force encapsulation
    // Use setEvents(_:) and getEvents() to set and get the event array.
    
    private var events: [Event]
    private var reuseIdentifier: String
    
    init(events: [Event], reuseIdentifier: String) {
        self.events = events
        self.reuseIdentifier = reuseIdentifier
    }
    
    func setEvents(_ newEvents: [Event]){
        events = newEvents
    }
    
    func getReuseIdentifier() -> String { return reuseIdentifier }
    
    func getEvents() -> [Event] { return events }
    
    // number of items in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    // cell for item at
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EventCollectionViewCell
        cell.configure(for: events[indexPath.item])
        return cell
    }
    

}
