//
//  AccountViewModel.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 11/27/21.
//

import Foundation
import RealmSwift

class AccountViewModel: ObservableObject {
    
    
    func logout() {
        let realm = try! Realm(configuration: Realm.Configuration.defaultConfiguration, queue: nil)
  
        guard
            let userId = User.currentUserId,
            let user = realm.object(ofType: User.self, forPrimaryKey: userId)
        else { return }
        
        User.currentUserId = nil
        try! realm.write {
            realm.delete(user)
        }
        
    }
}
