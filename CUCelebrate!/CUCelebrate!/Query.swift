//
//  Query.swift
//  CUCelebrate!
//
//  Created by Admin on 4/25/19.
//  Copyright © 2019 Cornell AppDev. All rights reserved.
//

import Foundation

enum QueryType {
    case name
    case date
}

class Query {
    var text: String
    var type: QueryType
    
    init(text: String, type: QueryType) {
        self.text = text
        self.type = type
    }
    
    static func queryToDict(_ query: Query) -> [String : Any] {
        return ["type": Query.typeToString(query.type), "query": query.text]
    }
    
    static func typeToString(_ type: QueryType) -> String {
        switch type {
        case .name: return "name"
        case .date: return "date"
        }
    }
}
