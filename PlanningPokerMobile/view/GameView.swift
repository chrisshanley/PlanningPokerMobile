//
//  GameView.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 11/27/21.
//

import Foundation
import SwiftUI
import RealmSwift

struct GameView: View {

    @State private var showCreateGame: Bool = false
    @State private var showAddItem: Bool = false
    @State private var showInvitePlayer: Bool = false
    @State private var showVote: Bool = false
    

    @State var craeteGameViewModel = QuickGameViewModel()
    @StateObject var viewModel: GameViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if let game = self.viewModel.game {
                    if game.items.count == 0 {
                        VStack {
                            Text("Looks like you don't have any items to vote on, please add some.")
                            Button(action: { self.showAddItem.toggle() }, label: { ButtonView(label: "Add Item") }).padding(.horizontal)
                        }
                    } else {
                        if let game = self.viewModel.game {
                            ScrollView {
                                VStack(alignment: HorizontalAlignment.leading, spacing: 0) {
                                    Text("Stories").font(.largeTitle)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                        
                                    Spacer().frame(height: 20)
                                    VStack(alignment: .leading, spacing: 0) {
                                        ForEach(game.items, id: \.self) { item in
                                            EstimationItem(game: game, item: item, user: self.viewModel.user).padding(0)
                                        }
                                    }
                                }
                                
                                VStack(alignment: HorizontalAlignment.leading, spacing: 0) {
                                    Text("Players").font(.largeTitle)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    Divider()
                                    ForEach(game.players, id: \.self) { item in
                                        HStack(alignment: .top, spacing: 0) {
                                            Text(item.displayName)
                                        }
                                        Divider()
                                    }
                                }
                            }
                            Button(action: { self.viewModel.endGame() }, label: { ButtonView(label: "End Game") }).padding(.horizontal)
                        }
                    }
                } else {
                    Button("Create Game") {
                        self.showCreateGame.toggle()
                    }
                    Spacer()
                }
                
            }
            .sheet(isPresented: self.$showAddItem) {
                if let game = self.viewModel.game {
                    AddItemView(isShowing: self.$showAddItem, viewModel: AddGameItemViewModel(user: self.viewModel.user, game: game))
                } else {
                    Text("Game not created yet")
                }
            }
//            .sheet(isPresented: self.$showInvitePlayer) {
//                if let game = self.viewModel.game {
//                    let viewModel = InviteViewModel(game: game, user: self.viewModel.user)
//                    InvitePlayerView(isShowing: self.$showInvitePlayer, viewModel: viewModel)
//                } else {
//                    Text("Game not created yet")
//                }
//            }
            .sheet(isPresented: self.$showCreateGame) {
                NavigationView {
                    CreateGameView(viewModel: self.craeteGameViewModel)
                        .navigationBarTitle(Text("Create Game"))
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                Button("Cancel") {
                                    self.showCreateGame.toggle()
                                }
                            }
                        }
                }
            }
            .toolbar(content: {
                ToolbarItemGroup(placement: .destructiveAction) {
                    Button("Add Ttem") {
                        self.showAddItem.toggle()
                    }
                }
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Invite Player") {
                        //self.showInvitePlayer.toggle()
                        self.viewModel.invite()
                    }
                }
            }).navigationTitle(self.viewModel.game?.name ?? "Current Game")
        }.onAppear {
            let realm = try! Realm(configuration: Realm.Configuration.defaultConfiguration, queue: nil)
            self.craeteGameViewModel.gameCreatedHandler = { self.showCreateGame.toggle() }
            if let id = User.currentUserId {
                self.craeteGameViewModel.user = realm.object(ofType: User.self, forPrimaryKey: id)
            }
        }
    }
}

struct EstimationItem: View {
    
    let game: PlanningPokerGame
    let item: PokerGameItem
    let user: User
    @State var showVote: Bool = false
    
    func itemTitle(item: PokerGameItem) -> String {
        var title = item.title
        if let estimate = item.estimate {
            title += " points: \(estimate)"
        }
        return title
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            HStack(alignment: .center, spacing: 0) {
                let model = VotingViewModel(game: self.game, item: self.item, user: self.user)
                let destination = VotingView(viewModel: model, isShowing: self.$showVote)
                let title = self.itemTitle(item: item)
                NavigationLink(destination: destination, isActive: self.$showVote) {
                    EmptyView()
                }
                
                VStack(alignment: .leading) {
                    Spacer().frame(height: 5)
                    Text(title).font(.headline)
                    Text(item.notes ?? "n/a").font(.caption)
                    Spacer().frame(height: 5)
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                Spacer()
                Image(systemName: "chevron.right").font(.body).padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
                                            
            }
            Divider()
        }
        .padding(0)
        .contentShape(Rectangle())
        .onTapGesture {
            self.showVote.toggle()
        }
    }
}
