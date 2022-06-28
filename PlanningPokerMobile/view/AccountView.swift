//
//  AccountView.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 11/27/21.
//

import Foundation
import SwiftUI

struct AccountView: View {
    var viewModel = AccountViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Text("Account")
                Button("Log Out") {
                    self.viewModel.logout()
                }
            }
        }
    }
}

