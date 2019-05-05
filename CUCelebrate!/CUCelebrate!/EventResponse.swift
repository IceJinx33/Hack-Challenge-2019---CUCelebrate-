//
//  EventResponse.swift
//  CUCelebrate!
//
//  Created by Admin on 4/26/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import Foundation
import UIKit

struct EventResponseEnvelope : Codable {
    var success: Bool
    var data: [EventResponse1]
}

struct EventResponse1 : Codable {
    var id: Int
    var title: String
    var month: Int
    var day: Int
    var year: Int
    var time: String
    var descr: String
    var location: String
    var category: String
    var interest: Int
    var imageURL: String
}

struct CreateEventBody : Codable {
    var title: String
    var date_posted: Int
    var time: String
    var descr: String
    var location: String
    var category: String
}

struct GetEvent: Codable {
    var title: String
    var date_posted: Int
    var time: String
    var descr: String
    var location: String
    var category: String
    var interest: Int
}
class JSONConverter {
    
    
    static func makeEventBody(_ event: Event) -> CreateEventBody {
        
        let dummyDate = 0
        let dummyCategory = "Cat"
        
        return CreateEventBody(title: event.eventName, date_posted: dummyDate, time: event.eventTime, descr: event.description, location: event.eventVenue, category: dummyCategory)
    }
    
    static func makeEventFromGet(_ event: GetEvent) -> Event {
        
        let dummyEventDate = "Date"
        
        return Event(eventName: event.title, eventDate: dummyEventDate, eventTime: event.time, eventVenue: event.location, description: event.descr, category: event.category)
    }
    
    static func makeEventFromGetAll(_ event: EventResponse1) -> Event {
        let url = URL(string: event.imageURL)
        var downloadImage: UIImage!
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                downloadImage = UIImage(data: data!)
            }
        }
        return Event(eventName: event.title,
                     eventDate: JSONConverter.eventIntToEventString(month: event.month,
                                                                    day: event.day,
                                                                    year: event.year),
                     eventTime: event.time,
                     eventVenue: event.location,
                     description: event.descr,
                     image: downloadImage,
                     category: event.category
                     )
    }
    
    static func eventIntToEventString(month: Int, day: Int, year: Int) -> String {
        var monthStr: String = ""
        switch month {
        case 1: monthStr = "Jan"
        case 2: monthStr = "Feb"
        case 3: monthStr = "Mar"
        case 4: monthStr = "Apr"
        case 5: monthStr = "May"
        case 6: monthStr = "Jun"
        case 7: monthStr = "Jul"
        case 8: monthStr = "Aug"
        case 9: monthStr = "Sep"
        case 10: monthStr = "Oct"
        case 11: monthStr = "Nov"
        case 12: monthStr = "Dec"
        default: monthStr = "NIL"
        }
        
        return monthStr + String(day) + ", " + String(year)
    }
    
}
