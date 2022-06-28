//
//  WelcomeViewModel.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 11/27/21.
//

import Foundation
import RealmSwift
import SwiftUI

class RootViewModel: ObservableObject {
    
    @Published var user: User?
    
    private var userToken: NotificationToken?
    
    init() {
        self.refreshUser()
    }
    
    func registerGlobalListeners() {
        let realm = try! Realm(configuration: Realm.Configuration.defaultConfiguration, queue: nil)
        self.userToken = realm.observe({ notification, realm in
            self.refreshUser()
        })
    }
    
    public func refreshUser() {
        let realm = try! Realm(configuration: Realm.Configuration.defaultConfiguration, queue: nil)
        if let userId = User.currentUserId {
            withAnimation {
                let u = realm.object(ofType: User.self, forPrimaryKey: userId)
                self.user = u
            }
        } else {
            withAnimation {
                self.user = nil
            }
        }
    }
}
