//
//  ErrorViewModel.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/21/22.
//

import Foundation
import SwiftUI
class ErrorViewModel: ObservableObject {
    
    @Published var currentError: Error?
    @Published var showError: Bool = false
    
    private var timer: Timer?
    
    func setError(error: Error) {
        withAnimation {
            self.showError = true
            self.currentError = error
            if let t = self.timer {
                t.invalidate()
            }
        }
        self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            withAnimation {
                self.showError = false
                self.currentError = nil
            }
        }
    }
}
