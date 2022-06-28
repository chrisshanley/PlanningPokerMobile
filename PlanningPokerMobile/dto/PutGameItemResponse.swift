//
//  PutGameItemResponse.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/7/22.
//

import Foundation
struct PutGameItemResponse: Codable {
    let title: String
    let itemKey: String
    let notes: String?
    let estimate: Int?

    enum CodingKeys: String, CodingKey {
        case title
        case notes
        case estimate = "accepted_estimate"
        case itemKey = "key"
    }
}

