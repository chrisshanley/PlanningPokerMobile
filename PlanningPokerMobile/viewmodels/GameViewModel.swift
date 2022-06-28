//
//  GameViewModel.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/5/22.
//

import Foundation
import RealmSwift
import SwiftUI
class GameViewModel: ObservableObject {
    
    @Published var game: PlanningPokerGame?
    @Published var joinGameCode: String = ""
    
    let user: User
    var gameItemToken: NotificationToken?
    var gameToken: NotificationToken?
    
    var gameName: String {
        return self.game?.name ?? "No game started"
    }
    
    init(user: User ) {
        self.user = user
        self.game = user.currentGame

        self.gameItemToken = self.game?.observe( keyPaths: ["items.estimate"], on: nil, { changes in
            switch changes {
                case .change(let object, let properties):
                    for property in properties {
                        print("Property '\(property.name)' of object \(object) changed to '\(property.newValue!)'")
                    }
                case .error(let error):
                    print("An error occurred: \(error)")
                case .deleted:
                    print("The object was deleted.")
            }
        })
        
        self.gameToken = self.user.observe( keyPaths: ["currentGame"], on: nil, { changes in
            switch changes {
                case .change(let object, let properties):
                    for property in properties {
                        print("Property '\(property.name)' of object \(object) changed to '\(property.newValue!)'")
                        
                        self.game = user.currentGame
                    }
                case .error(let error):
                    print("An error occurred: \(error)")
                case .deleted:
                    print("The object was deleted.")
            }
        })
    }
    
    func handleGameChanged() {
        
    }
    
    func createGame() {
        
    }
    
    func joinGame() {
        
    }
    
    func endGame() {
        withAnimation {
            self.game = nil
        }
    }
    
    func invite() {

        if let game = self.user.currentGame {
            let sharable: [Any] = [
                "Easy Agile Planning Game Code: \(game.code)",
            ]
            
            let activityVC = UIActivityViewController(activityItems: sharable, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook]
            
            let allScenes = UIApplication.shared.connectedScenes
            let scene = allScenes.first { $0.activationState == .foregroundActive }

            if let windowScene = scene as? UIWindowScene {
                windowScene.keyWindow?.rootViewController?.present(activityVC, animated: true, completion: nil)
            }
        }
    }
}
