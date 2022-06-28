//
//  User.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 11/27/21.
//

import Foundation
import RealmSwift

class User: Object {
    
    static var currentUserId: String? {
        set {
            if let id = newValue {
                UserDefaults.standard.set(id, forKey: "current-user-id")
            } else {
                UserDefaults.standard.removeObject(forKey: "current-user-id")
            }
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.string(forKey: "current-user-id")
        }
    }
    
    @Persisted(primaryKey: true) private(set) var id: String = ""
    @Persisted private(set) var username: String = ""
    @Persisted private(set) var token: String = ""

    @Persisted private(set) var currentGame: PlanningPokerGame?
    
    override init(){}
    
    init(dto: LoginResponse) {
        User.currentUserId = dto.account.key
        self.id = dto.account.key
        self.token = dto.jwt
        self.username = dto.account.username
    }
    
    init(quickGame: QuickGameResponse) {
        User.currentUserId = quickGame.creator.key
        self.id = quickGame.creator.key
        self.token = quickGame.token
        self.username = quickGame.creator.username
    }
    
    public func assignGame(game: PlanningPokerGame) {
        self.currentGame = game
    }
}

