//
//  QuickGameViewModel.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/4/22.
//

import Foundation
import RealmSwift
import UIKit


class QuickGameViewModel: ObservableObject {

    @Published var gameName: String = ""
    @Published var ownerName: String = ""
    typealias GameCreatedHandler = ()->Void
    
    weak var errorHandler: ErrorViewModel?
    var gameCreatedHandler: GameCreatedHandler?
    let api: ApiClient
    var user: User?
    var token: NotificationToken?
    
    init(user: User? = nil) {
        self.user = user
        self.api = ApiClient(host: AppUtils.host)
        self.registerListener()
    }
    
    func startGame() {
        let token: String? = self.user?.token
        
        Task {
            do {
                if let t = token {
                    let results = try await self.api.createGame(token: t, name: self.gameName)
                    await self.handleGameReady(dto: results)
                } else {
                    let results = try await self.api.quickGame(ownerName: self.ownerName, gameName: self.gameName)
                    await self.handleQuickGameReady(dto: results)
                }
            } catch(let error) {
                DispatchQueue.main.sync {
                    self.errorHandler?.setError(error: error)
                    print("error: \(error)")
                }
            }
        }
    }
    
    @MainActor
    private func handleQuickGameReady(dto: QuickGameResponse) {
        let game = PlanningPokerGame(dto: dto.game)
        let user = User(quickGame: dto)
        user.assignGame(game: game)
        let realm = try! Realm(configuration: Realm.Configuration.defaultConfiguration, queue: nil)
        try! realm.write({
            realm.add(user, update: Realm.UpdatePolicy.all)
            realm.add(game, update: Realm.UpdatePolicy.all)
        })
    }
    
    @MainActor
    private func handleGameReady(dto: Game) {
        let game = PlanningPokerGame(dto: dto)
        let realm = try! Realm(configuration: Realm.Configuration.defaultConfiguration, queue: nil)
        try! realm.write({
            realm.add(game, update: Realm.UpdatePolicy.all)
            self.user?.assignGame(game: game)
        })
        self.gameCreatedHandler?()
    }
    
    func registerListener() {
        let realm = try! Realm(configuration: Realm.Configuration.defaultConfiguration, queue: nil)
        self.token = realm.observe({ notification, realm in
            if let id = User.currentUserId, let user = realm.object(ofType: User.self, forPrimaryKey: id) {
                self.user = user
                print("\(self) - user assigned: \(self.user)")
            }
        })
    }
}

