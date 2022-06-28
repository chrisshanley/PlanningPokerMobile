//
//  WelcomeView.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 11/27/21.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    
    @State var createGameViewModel = QuickGameViewModel(user: nil)
    @State var showQuickGame: Bool = false
    @State var showJoinGame: Bool = false
   
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Spacer().frame(height: 40)
                NavigationLink(destination: CreateGameView(viewModel: self.createGameViewModel), isActive: self.$showQuickGame) {
                    EmptyView()
                }
                
                NavigationLink(destination: JoinGameView(), isActive: self.$showJoinGame) {
                    EmptyView()
                }
                Group {
                    Text("Start a quick planning session.")
                    Spacer().frame(height: 10)
                    Button {
                        self.showQuickGame.toggle()
                    } label: {
                        ButtonView(label: "Quick Game")
                    }
                    .padding(.horizontal)
                }
                Group {
                    Spacer().frame(height: 25)
                    Divider().padding(.horizontal)
                    Spacer().frame(height: 10)
                }
                Group {
                    Text("Or join game.")
                    Spacer().frame(height: 10)
                    Button {
                        self.showJoinGame.toggle()
                    } label: {
                        ButtonView(label: "Join Game")
                    }
                    .padding(.horizontal)
                }
                Spacer()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationTitle("Welcome")
        
         }
    }
}

