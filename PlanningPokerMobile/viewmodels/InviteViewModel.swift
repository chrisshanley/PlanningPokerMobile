//
//  InviteViewModel.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/12/22.
//

import Foundation
import UIKit

class InviteViewModel: ObservableObject {
    
    let api: AuthorizedApiClient
    let game: PlanningPokerGame
    @Published var email: String = ""
    
    
    init(game: PlanningPokerGame, user: User) {
        self.game = game
        self.api = AuthorizedApiClient(host: AppUtils.host, token: user.token)
    }

}
