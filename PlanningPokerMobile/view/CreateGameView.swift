//
//  QuickGameView.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/4/22.
//

import Foundation
import SwiftUI
import RealmSwift

struct CreateGameView: View {
    
    enum Field {
        case gameName, ownerName
    }
    @FocusState private var field: Field?

    @StateObject var viewModel: QuickGameViewModel
    @EnvironmentObject var errorViewModel: ErrorViewModel
    
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Game Name", text: self.$viewModel.gameName, prompt: nil)
                    .textContentType(.none)
                    .submitLabel(.next)
                    .focused(self.$field, equals: .gameName)
                    .padding(.horizontal)
                Divider().padding(.horizontal)
                TextField("Display Name", text: self.$viewModel.ownerName, prompt: nil)
                    .textContentType(.none)
                    .submitLabel(.next)
                    .focused(self.$field, equals: .ownerName)
                    .padding(.horizontal)
                Divider().padding(.horizontal)
                Spacer().frame(height: 20)
                Button(action: {
                    self.field = nil
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    self.viewModel.startGame()
                }, label:{
                    ButtonView(label: "Start Game").padding()
                })
            }
        }
        .onAppear(perform: {
            self.viewModel.errorHandler = self.errorViewModel
        })
        .onSubmit {
            switch self.field {
                case .ownerName:
                break
                
                case .gameName:
                break
                
                case .none:
                break
            }
        }
    }
    
//    mutating func manageGameReady(user: User) {
//        self.token = user.observe( keyPaths: ["currentGame"], on: nil, { changes in
//            switch changes {
//                case .change(let object, let properties):
//                    for property in properties {
//                        print("Property '\(property.name)' of object \(object) changed to '\(property.newValue!)'")
//                        if let _ = user.currentGame {
//                            self.isShowing.toggle()
//                        }
//                    }
//                case .error(let error):
//                    print("An error occurred: \(error)")
//                case .deleted:
//                    print("The object was deleted.")
//            }
//        })
//    }
}

