//
//  GameResponse.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/11/22.
//

import Foundation

struct Game: Codable {
    let key: String
    let name: String
    let modorator: Account
    let players: [Account]
    let items: [GameItem]
    let gameCode: String
    
    enum CodingKeys: String, CodingKey {
        case gameCode = "game_code"
        case key, name, modorator, players, items
    }
}

struct GameItem: Codable {
    let title: String
    let itemKey: String
    let notes: String?
    let estimate: Int?
    let votes: [GameItemVote]
    enum CodingKeys: String, CodingKey {
        case title
        case notes
        case votes
        case estimate = "accepted_estimate"
        case itemKey = "key"
    }
}


struct GameItemVote: Codable {
    let key: String
    let value: Int
    let voter: String
    let voterId: String
    
    enum CodingKeys: String, CodingKey {
        case key
        case value
        case voter
        case voterId = "voter_id"
    }
}

