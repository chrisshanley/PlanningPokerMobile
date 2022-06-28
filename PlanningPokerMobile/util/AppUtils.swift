//
//  AppUtils.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 11/27/21.
//

import Foundation
struct AppUtils {
    static var host: String {
        guard
            let transport = Bundle.main.infoDictionary?["protocol"] as? String,
            let host = Bundle.main.infoDictionary?["host"] as? String
        else { fatalError() }
        return  transport + "://" + host
    }
}
