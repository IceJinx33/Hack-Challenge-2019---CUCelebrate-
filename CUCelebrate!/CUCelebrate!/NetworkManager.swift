//
//  NetworkManager.swift
//  CUCelebrate!
//
//  Created by Admin on 4/24/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {

    static func getResultsFromQuery(query: Query) -> [Event]{
        
        // 1: Gather request body
        let parameters = Query.queryToDict(query)
        
        // 2: TODO send the request body over the network
        Alamofire.request(Constants.queryEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).validate().responseData { (response) in
            // TODO do something with the response here
            
        }
        // 3: TODO interpret the response into a Swift-readable format
        
        return generateDummyData()
    }
    
    static func updateEvent(user: String, event: Event) {
        // 1. Gather request body
        let parameters = EventResponse.makeEventResponse(event)
        
        // 2: TODO send the request body over the network
//        Alamofire.request(Constants.userEventsEndpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: [:]).validate().responseData { (response) in
//            // TODO do something with the response here
//
//        }
        
    }
    
    static func generateDummyData() -> [Event] {
        var list : [Event] = []
        for i in 1..<4 {
            list.append(Event(eventName: "Event \(i) from DB",
                eventDate: "May \(i), 2019", eventTime: "\(6+i) PM",
                eventVenue: "Gates Hall",
                description: "Event number \(i) of an exciting list of events you searched for. Actual search TBA, as networking isn't ready yet."))
        }
        return list
    }
}
