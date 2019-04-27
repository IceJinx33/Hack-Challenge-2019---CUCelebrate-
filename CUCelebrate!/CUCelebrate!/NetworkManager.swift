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
    let queryEndpoint = "TODO add endpoint to make a query"
    
    static func getResultsFromQuery(query: Query) -> [Event]{
        let parameters = Query.queryToDict(query)
        // TODO send this over the network
        
        var list = [Event(eventName: "Event from DB", eventDate: "Today", eventTime: "10 PM", eventVenue: "Gates Hall", description: "A sample event retrieved from the database.")]
        list.append(contentsOf: list)
        list.append(contentsOf: list)
        return list
        // Step 1: Send query
//        Alamofire.request(queryEndpoint, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate().responseData {
//            response in
//
//            switch response.result {
//
//            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//                if let response = try? jsonDecoder.decode(User.self, from: data) {
//                    print("Received user with token \(response.token)")
//                }
//
//
//            case .failure(let error): print(error.localizedDescription)
//            }
//        }
        
        // Step 2: Return the results in a Swift-readable format
    }
}
