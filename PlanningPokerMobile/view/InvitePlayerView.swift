//
//  InvitePlayerView.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/12/22.
//

import Foundation
import SwiftUI

struct InvitePlayerView: View {
    
    @Binding var isShowing: Bool
    @State var isSharing: Bool = false
    @StateObject var viewModel: InviteViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Share your game code.")
                    Text(self.viewModel.game.code).font(.largeTitle)
                }
            }
            .toolbar(content: {
                ToolbarItemGroup(placement: .navigationBarLeading, content: {
                    Button("Dismiss") {
                        self.isShowing = false
                    }
                })
                ToolbarItemGroup(placement: .destructiveAction) {
                    Button(action: { }, label: { Image(systemName: "square.and.arrow.up")})
                }
            }).navigationTitle("Invite Player")
        }
    }
}
