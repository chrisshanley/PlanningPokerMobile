//
//  PutGameItemRequest.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/7/22.
//

import Foundation
struct PutGameItemRequest: Codable {
    let title: String
    let notes: String?
    let estimate: Int?
    let itemKey: String?

    enum CodingKeys: String, CodingKey {
        case title
        case notes
        case estimate = "accepted_estimate"
        case itemKey = "item_id"
    }
}

