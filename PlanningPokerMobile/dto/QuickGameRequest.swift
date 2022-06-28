//
//  QuickGameRequest.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/4/22.
//

import Foundation
struct QuickGameRequest: Codable {
    let name: String
    let ownerName: String
    enum CodingKeys: String, CodingKey {
        case name
        case ownerName = "display_name"
    }
}

struct CreateGameRequest: Codable {
    let name: String
    let teamKey: String?
    enum CodingKeys: String, CodingKey {
        case name
        case teamKey = "team"
    }
}



struct JoinGameRequest: Codable {
    let displayName: String
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
    }
}
