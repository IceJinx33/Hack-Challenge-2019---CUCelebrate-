//
//  EventResponse.swift
//  CUCelebrate!
//
//  Created by Admin on 4/26/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import Foundation

struct EventResponseEnvelope : Codable {
    var events: [EventResponse]
}

struct EventResponse : Codable {
    var name: String
    var date: String
    var time: String
    var venue: String
    var desc: String
    var isMyEvent: Bool
    var image: String // TODO: Be able to receive images from DB
    
    static func makeEventResponse(_ event: Event) -> EventResponse {
        return EventResponse(name: event.eventName, date: event.eventDate, time: event.eventTime, venue: event.eventVenue, desc: event.description, isMyEvent: event.isMyEvent, image: "TODO make image")
    }
}
// for JSON that looks like this:
//{
//    "events": [
//        {
//        "name": "Cornell Networking Event",
//        "date": "Soon",
//        "time": "Soon",
//        "venue": "iPhones, I guess",
//        "desc": "A networking event to exchange events over networks."
//        "isMyEvent": true
//        }
//    ]
//}
