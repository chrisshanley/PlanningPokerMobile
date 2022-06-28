//
//  LoginView.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 11/27/21.
//

import Foundation
import SwiftUI
struct LoginView: View {
    
    enum Field {
        case username, password
    }
    
    @State private var viewModel: LoginViewModel = LoginViewModel()
    @FocusState private var field: Field?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    TextField("Username", text: self.$viewModel.username, prompt: nil)
                        .textContentType(.emailAddress)
                        .submitLabel(.next)
                        .focused(self.$field, equals: .username)
                    Divider()
                    SecureField("Password", text: self.$viewModel.password, prompt: nil)
                        .focused(self.$field, equals: .password)
                        .submitLabel(.done)
                    Spacer(minLength: 20)
                    Button("Log In") {
                        self.field = nil
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        self.viewModel.login()
                    }
                }
                .onSubmit {
                    switch self.field {
                        case .username:
                            self.field = .password
                            print("username")
                            break
                        case .password:
                            print("password")
                            break
                        case .none:
                            print("none")
                            break
                    }
                }
            }
        }
    }
}
