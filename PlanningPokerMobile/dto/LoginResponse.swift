//
//  LoginResponse.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 11/27/21.
//

import Foundation
struct LoginResponse: Codable {
    let jwt: String
    let account: Account
}

struct Account: Codable {
    let key: String
    let username: String
    let type: AccountType
    enum CodingKeys: String, CodingKey {
        case key, username
        case type = "account_type"
    }
}

struct AccountType: Codable {
    let name: String
    let displayName: String
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case displayName = "display_name"
    }
}
