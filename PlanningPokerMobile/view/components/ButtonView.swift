//
//  ButtonView.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/15/22.
//

import Foundation
import SwiftUI

struct ButtonView: View {
    let label: String
    var body: some View {
        Text(self.label)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .foregroundColor(.white)
            .background(Color.gray)
            .cornerRadius(5)
        }
}
