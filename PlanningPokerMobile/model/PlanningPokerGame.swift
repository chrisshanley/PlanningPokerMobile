//
//  Game.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/5/22.
//

import Foundation
import RealmSwift
class PlanningPokerGame: Object {
    
    @Persisted(primaryKey: true) private(set) var id: String = ""
    @Persisted private(set) var name: String = ""
    @Persisted private(set) var code: String = ""
    @Persisted private(set) var items: List<PokerGameItem> = List<PokerGameItem>()
    @Persisted private(set) var players: List<GamePlayer> = List<GamePlayer>()
 
    override init(){}
    
    init(dto: Game) {
        self.name = dto.name
        self.id = dto.key
        self.code = dto.gameCode
        super.init()
        
        for i in dto.items {
            self.addItem(item: PokerGameItem(dto: i))
        }
        
        for p in dto.players {
            self.addPlayer(item: GamePlayer(dto: p))
        }
    }
    
    func addItem(item: PokerGameItem) {
        self.items.append(item)
    }
    
    func addPlayer(item: GamePlayer) {
        self.players.append(item)
    }
}
