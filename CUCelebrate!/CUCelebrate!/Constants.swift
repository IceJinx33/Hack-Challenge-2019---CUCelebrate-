//
//  Constants.swift
//  CUCelebrate!
//
//  Created by Admin on 4/26/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    // MARK: Placeholders
    static let placeholderImage : UIImage = UIImage(named: "cu_placeholder")!
    static let placeholderEvent : Event = Event(eventName: "Placeholder Event",
                                                eventDate: "May 5th, 2019",
                                                eventTime: "9:00 PM",
                                                eventVenue: "Gates Hall",
                                                description: "A placeholder event.")
    // MARK: UI numbers
    static let padding : CGFloat = 5
    static let titleFontSize : CGFloat = 20
    static let labelHeight : CGFloat = 16
    static let eventTitleHeight : CGFloat = 20
    
    // MARK: Networking Endpoints
    static let queryEndpoint : String = "TODO add query endpoint"
    static let userEventsEndpoint : String = "TODO add user event get/post endpoint"
    
}
