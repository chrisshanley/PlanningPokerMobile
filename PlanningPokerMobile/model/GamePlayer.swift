//
//  GamePlayer.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/18/22.
//

import Foundation
import RealmSwift

class GamePlayer: Object {
    
    @Persisted(primaryKey: true) private(set) var id: String = ""
    @Persisted private(set) var displayName: String = ""
   
    override init(){}
    init(dto: Account) {
        self.id = dto.key
        self.displayName = dto.username
    }
}
