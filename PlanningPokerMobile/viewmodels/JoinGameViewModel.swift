//
//  JoinGameViewModel.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/16/22.
//

import Foundation
import RealmSwift

class JoinGameViewModel: ObservableObject {
    @Published var gameCode: String = ""
    @Published var displayName: String = ""
    
    let api = ApiClient(host: AppUtils.host)
    
    func joinGame() {
        Task {
            do {
                let response = try await self.api.joinGame(displayName: self.displayName, gameCode: self.gameCode)
                await self.handleGameJoined(dto: response)
            } catch(let error) {
                print("\(self) error : \(error)")
            }
        }
    }
    
    @MainActor
    func handleGameJoined(dto: QuickGameResponse) {
        let game = PlanningPokerGame(dto: dto.game)
        let user = User(quickGame: dto)
        user.assignGame(game: game)
        let realm = try! Realm(configuration: Realm.Configuration.defaultConfiguration, queue: nil)
        try! realm.write({
            realm.add(user, update: Realm.UpdatePolicy.all)
            realm.add(game, update: Realm.UpdatePolicy.all)
        })
    }
}
