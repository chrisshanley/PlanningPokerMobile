//
//  JoinGameView.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/16/22.
//

import Foundation
import SwiftUI

struct JoinGameView: View {
    
    enum Field {
        case gameCode, displayName
    }
    
    @FocusState private var field: Field?
    @State var viewModel: JoinGameViewModel = JoinGameViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                TextField("Game Code", text: self.$viewModel.gameCode, prompt: nil)
                    .textContentType(.none)
                    .submitLabel(.next)
                    .focused(self.$field, equals: .gameCode)
                    .padding(.horizontal)
                Divider().padding(.horizontal)
                TextField("Display Name", text: self.$viewModel.displayName, prompt: nil)
                    .textContentType(.none)
                    .submitLabel(.next)
                    .focused(self.$field, equals: .displayName)
                    .padding(.horizontal)
                Divider().padding(.horizontal)
                Spacer().frame(height: 20)
                Button(action: {
                    self.field = nil
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    self.viewModel.joinGame()
                }, label:{
                    ButtonView(label: "Join").padding()
                })
            }
        }
        .onSubmit {
            switch self.field {
                case .gameCode:
                break
                
                case .displayName:
                break
                
                case .none:
                break
            }
        }
    }
}
