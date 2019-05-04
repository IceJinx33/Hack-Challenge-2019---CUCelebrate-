//
//  EventResponse.swift
//  CUCelebrate!
//
//  Created by Admin on 4/26/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import Foundation

struct EventResponseEnvelope : Codable {
    var success: Bool
    var data: [EventResponse1]
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

struct EventResponse1 : Codable {
    var id: Int
    var title: String
    // Warning: Jan 11th 2019 (1112019) = Nov 1st 2019 (1112019)
    var date_posted: Int
    var time: Int // first 4 digits for start, last 4 for end.
    var descr: String
    var location: String
    var category: String
    var interest: Int
}

struct CreateEventBody : Codable {
    var title: String
    // Warning: Jan 11th 2019 (1112019) = Nov 1st 2019 (1112019)
    var date_posted: Int
    var time: Int // first 4 digits for start, last 4 for end.
    var descr: String
    var location: String
    var category: String
}

struct GetEvent: Codable {
    var title: String
    // Warning: Jan 11th 2019 (1112019) = Nov 1st 2019 (1112019)
    var date_posted: Int
    var time: Int // first 4 digits for start, last 4 for end.
    var descr: String
    var location: String
    var category: String
    var interest: Int
}
class JSONConverter {
    
    
    static func makeEventBody(_ event: Event) -> CreateEventBody {
        
        let dummyDate = 0
        let dummyCategory = "Cat"
        
        return CreateEventBody(title: event.eventName, date_posted: dummyDate, time: timeStringToInt(event.eventTime), descr: event.description, location: event.eventVenue, category: dummyCategory)
    }
    
    static func makeEventFromGet(_ event: GetEvent) -> Event {
        
        let dummyEventDate = "Date"
        let dummyEventTime = "Time"
        
        return Event(eventName: event.title, eventDate: dummyEventDate, eventTime: dummyEventTime, eventVenue: event.location, description: event.descr)
    }
    
    // dateStringToInt( str: String ) -> Int
    // Returns the int representation of a time range.
    // i.e. "9:00 AM - 5:00 PM" -> 9001700.
    static func timeStringToInt(_ str: String) -> Int {
        // splits into an easier format
        // "9:00 AM - 5:00 PM" -> ["9", "00", "AM", "5", "00", "PM"]
        let strs = str.split(whereSeparator: {
            let separators : [Character] = [" ", ":", "-"]
            for s in separators {
                if $0 == s { return true }
            }
            return false
        })
        
        let first = simplifyTimeString(time: String(strs[0] + strs[1]), ampm: String(strs[2]))
        let second = simplifyTimeString(time: String(strs[3] + strs[4]), ampm: String(strs[5]))
        return Int(first + second)!
        
    }
    
    static func timeIntToString(_ int: Int) -> String {
        // Cannot implement: No way to get numbers with leading zeroes.
        return "time int to string unimplemented"
    }
    // simplifyTimeString (time: String, ampm: String) -> String
    // Requires: time is length 3 or 4, time has only digits in it, and
    // ampm is either "AM" or "PM".
    // Returns a string that accounts for AM / PM differences.
    // i.e. ("900", "AM") -> "900", and ("800", "PM") -> "2000"
    static func simplifyTimeString(time: String, ampm: String) -> String {
        var number = Int(time)!
        if ampm == "PM" {number += 1200}
        return String(number)
    }
    
}
