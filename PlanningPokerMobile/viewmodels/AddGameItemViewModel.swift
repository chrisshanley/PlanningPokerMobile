//
//  AddGameItemViewModel.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/6/22.
//

import Foundation
import RealmSwift
class AddGameItemViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var notes: String = ""
    @Published var gameItem: PokerGameItem?
    
    let user: User
    let api: AuthorizedApiClient
    let game: PlanningPokerGame
    
    init(user: User, game: PlanningPokerGame) {
        self.user = user
        self.game = game
        self.api = AuthorizedApiClient(host: AppUtils.host, token: self.user.token)
    }
    
    func addItem() {
        let gameId = self.game.id
        Task {
            do {
                let results = try await self.api.putItem(gameKey: gameId, title: self.title, notes: self.notes, estimate: nil, itemKey: nil)
                await self.itemAdded(item: results)
            } catch(let error) {
                print("\(self) - error: \(error)")
            }
        }
    }
    
    @MainActor
    func itemAdded(item: PutGameItemResponse) {
        let gameItem = PokerGameItem(dto: item)
        let realm = try! Realm(configuration: Realm.Configuration.defaultConfiguration, queue: nil)
        try! realm.write({
            self.game.addItem(item: gameItem)
            realm.add(game, update: Realm.UpdatePolicy.all)
        })
        self.gameItem = gameItem
    }
}
