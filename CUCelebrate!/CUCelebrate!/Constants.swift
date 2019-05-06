//
//  Constants.swift
//  CUCelebrate!
//
//  Created by Admin on 4/26/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import Foundation
import UIKit


// This is a central place to hold (most) constants that may be
// changed later.
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
    static let titleFontSize : CGFloat = 24
    static let labelHeight : CGFloat = 16
    static let eventTitleHeight : CGFloat = 20
    static let cellHeight : CGFloat = 200
    
    // MARK: UI fonts and font names
    static let titleFont : UIFont = UIFont(name: "Copperplate-Bold", size: Constants.titleFontSize)!
    static let eventTitleFont : UIFont = UIFont(name: "AmericanTypewriter-Bold", size: 20)!
    static let infoLabelFont : UIFont = UIFont(name: "Optima-Bold", size: 16)!
    
    // MARK: UI Colors
    static let backgroundColor : UIColor = UIColor.clear
    static let titleTextColor : UIColor = .white
    
    // MARK: Networking Endpoints
    static let queryEndpoint : String = "TODO add query endpoint"
    static let userEventsEndpoint : String = "TODO add user event get/post endpoint"
    static let getAllEventsEndpoint : String = "http://34.74.36.56/api/events/"
}
