//
//  VotingViewModel.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/8/22.
//

import Foundation
import RealmSwift

class Vote: Hashable, Equatable, Identifiable {
    static func == (lhs: Vote, rhs: Vote) -> Bool {
        return lhs.id == rhs.id
    }
    
    let displayName: String
    let value: Int
    let id: String
    
    init(displayName: String, value: Int, id: String) {
        self.displayName = displayName
        self.value = value
        self.id = id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
}


class VotingViewModel: ObservableObject {
    let item: PokerGameItem
    let api: AuthorizedApiClient
    let game: PlanningPokerGame
    
    @Published var currentVoteId: String?
    @Published var currentVotes: [Vote]
    @Published var isVoteVisible: Bool
    @Published var acceptedEstimate: String = ""
    
    private(set) var currentVote: Int?
    
    var average: Float {
        return self.currentVotes.reduce(0.0, { count, item in return count + Float(item.value) }) / Float(self.currentVotes.count)
    }
    
    init(game: PlanningPokerGame, item: PokerGameItem, user: User ) {
        self.api = AuthorizedApiClient(host: AppUtils.host, token: user.token)
        self.item = item
        self.game = game
        self.isVoteVisible = false
        self.currentVotes = self.item.votes.map({ item in return Vote(displayName: item.voter, value: item.estimate, id: item.voterId )})
    }
    
    func vote(value: Int) {
        let gameId = self.game.id
        let itemId = self.item.id
        self.currentVote = value
        Task {
            do {
                let results = try await  self.api.vote(gameKey: gameId, itemKey: itemId, estimate: value)
                await self.handleVoted(results: results)
            } catch( let error ) {
                print("\(self) - error voting: \(error)")
            }
        }
    }
    
    @MainActor
    func handleVoted(results: Game) {
        if let serverItem = results.items.first(where: { item in return item.itemKey == self.item.id }) {
            for vote in serverItem.votes {
                self.item.addVote(dto: vote)
            }
        } else {
            // handle error
        }
        
        objectWillChange.send()
        self.currentVotes = self.item.votes.map({ item in return Vote(displayName: item.voter, value: item.estimate, id: item.voterId )})
    }
    
    
    
    func endVote() {
        let gameId = self.game.id
        let itemId = self.item.id
        let estimate = Int(self.acceptedEstimate)
        let notes = self.item.notes
        let title = self.item.title
        
        Task {
            do {
                let results = try await self.api.putItem(gameKey: gameId, title: title, notes: notes, estimate: estimate, itemKey: itemId)
                await self.handleEstimateAccepted(dto: results)
            } catch (let error ) {
                print("endVote: \(error)")
            }
        }
    }
    
    @MainActor
    func handleEstimateAccepted(dto: PutGameItemResponse)  {
        let realm = try! Realm(configuration: Realm.Configuration.defaultConfiguration, queue: nil)
        try! realm.write({
            self.item.estimate = dto.estimate
        })
    }
    
    func restartVote() {
        
    }
    
    func showHand() {
        self.isVoteVisible.toggle()
    }
    
    var votingValues: [Vote] {
        return [
            Vote(displayName: "?", value: 0, id: "?"),
            Vote(displayName: "1", value: 1, id: "1"),
            Vote(displayName: "2", value: 2, id: "2"),
            Vote(displayName: "3", value: 3, id: "3"),
            Vote(displayName: "5", value: 5, id: "5"),
            Vote(displayName: "8", value: 8, id: "8"),
            Vote(displayName: "13", value: 13, id: "13"),
            Vote(displayName: "21", value: 21, id: "21")
        ]
    }
}
