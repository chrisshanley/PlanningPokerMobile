//
//  GameItem.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/5/22.
//

import Foundation
import RealmSwift
class PokerGameItem: Object {
    
    @Persisted(primaryKey: true) private(set) var id: String = ""
    @Persisted private(set) var title: String = ""
    @Persisted private(set) var notes: String?
    @Persisted private(set) var votes: List<PokerItemVote> = List<PokerItemVote>()
    @Persisted var estimate: Int?
    
    override init(){}
   
    init(dto: PutGameItemResponse) {
        self.id = dto.itemKey
        self.title = dto.title
        self.notes = dto.notes
        self.estimate = dto.estimate
    }
    
    init(dto: GameItem) {
        self.id = dto.itemKey
        self.title = dto.title
        self.notes = dto.notes
        self.estimate = dto.estimate
    }
    
    func addVote(dto: GameItemVote) {
        let realm = try! Realm(configuration: Realm.Configuration.defaultConfiguration, queue: nil)
        if let existing = self.votes.first(where: {vote in return vote.id == dto.key }) {
            try! realm.write({
                existing.estimate = dto.value
            })
        } else {
            let newVote = PokerItemVote(dto: dto)
            try! realm.write({
                self.votes.append(newVote)
                realm.add(self, update: Realm.UpdatePolicy.all)
            })
        }
    }
}

class PokerItemVote: Object {
    
    @Persisted(primaryKey: true) private(set) var id: String = ""
    @Persisted private(set) var voter: String = ""
    @Persisted private(set) var voterId: String = ""
    @Persisted var estimate: Int = 0
    
    override init(){}
   
    init(dto: GameItemVote) {
        self.id = dto.key
        self.voter = dto.voter
        self.voterId = dto.voterId
        self.estimate = dto.value
    }
}
