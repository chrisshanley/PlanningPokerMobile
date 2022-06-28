//
//  LoginViewModel.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 11/27/21.
//

import Foundation
import SwiftUI
import RealmSwift

class LoginViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    let api: ApiClient
    
    init() {
        self.api = ApiClient(host: AppUtils.host)
    }
    
    func login() {
        Task {
            do {
                let response = try await self.api.login(username: self.username, password: self.password)
                self.saveUser(response: response)
            }
            catch( let error ) {
                print("\(self) error: \(error)")
            }
        }
    }
    
    private func saveUser(response: LoginResponse) {
        let realm = try! Realm(configuration: Realm.Configuration.defaultConfiguration, queue: nil)
        let user = User(dto: response)
        try! realm.write({
            realm.add(user, update: Realm.UpdatePolicy.all)
        })
    }
}
