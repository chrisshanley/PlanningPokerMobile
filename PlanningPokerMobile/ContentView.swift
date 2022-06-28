//
//  ContentView.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 11/27/21.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    @StateObject var viewModel = RootViewModel()
    @EnvironmentObject var errorViewModel: ErrorViewModel
    
    var body: some View {
        if let user = self.viewModel.user {
            MainView(user: user)
                .onAppear {
                    DispatchQueue.main.async {
                        self.viewModel.registerGlobalListeners()
                        self.viewModel.refreshUser()
                    }
                }
        } else {
            WelcomeView()
                .onAppear {
                    DispatchQueue.main.async {
                        self.viewModel.registerGlobalListeners()
                        self.viewModel.refreshUser()
                    }
                }

        }
    }
}
