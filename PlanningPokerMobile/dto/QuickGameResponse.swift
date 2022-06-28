//
//  QuickGameResponse.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/4/22.
//

import Foundation

struct QuickGameResponse: Codable {
    let token: String
    let creator: Account
    let game: Game
}
