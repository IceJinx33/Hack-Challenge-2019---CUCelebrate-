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
    
    static let NETWORKS_ON : Bool = false
    
    static func getAllEvents() -> [Event] {
        if NETWORKS_ON {
            var result : [Event] = []
            Alamofire.request(Constants.getAllEventsEndpoint, method: .get).validate().responseData { (response) in
                
                switch response.result {
                    
                case .success(let data):
                    
                    let jsonDecoder = JSONDecoder()
                    if let eventResponse = try? jsonDecoder.decode(EventResponseEnvelope.self, from: data) {
                        if eventResponse.success {
                            result = eventResponse.data.map({return JSONConverter.makeEventFromGetAll($0)})
                        } else {
                            result = []
                        }
                    } else {
                        print("Invalid response data")
                        result = []
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    result = []
                }
                
            }
            return result
        }
        return generateDummyData()
        
    }
    
    static func updateEvent(user: String, event: Event) {
        // 1. Gather request body
        let parameters = EventResponse.makeEventResponse(event)
        
        // send over network
        
        
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
