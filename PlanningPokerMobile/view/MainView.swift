//
//  MainView.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 11/27/21.
//

import Foundation
import SwiftUI
import RealmSwift
struct MainView: View {
    
    let user: User
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        return TabView {
            GameView(viewModel: GameViewModel(user: self.user))
                .tabItem {
                    Label("Game", image: "")
                }
            TeamView()
                .tabItem {
                    Label("Teams", image: "")
                }
            AccountView()
                .tabItem {
                    Label("Account", image: "")
                }
        }
    }
}
