//
//  File.swift
//  CUCelebrate!
//
//  Created by Aliva Das on 4/24/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import Foundation
import UIKit

class Event {
    
    var eventName: String
    var eventDate: String
    var eventTime: String
    var eventVenue: String
    var description: String
    var isMyEvent: Bool
    var image: UIImage
    
    init(eventName: String, eventDate: String, eventTime: String, eventVenue: String, description: String, isMyEvent: Bool = false, image: UIImage = UIImage(named: "cu_placeholder")!){
        self.eventName = eventName
        self.eventDate = eventDate
        self.eventTime = eventTime
        self.eventVenue = eventVenue
        self.description = description
        self.isMyEvent = isMyEvent
        self.image = image
    }
}
