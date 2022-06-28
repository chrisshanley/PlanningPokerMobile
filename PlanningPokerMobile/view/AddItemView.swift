//
//  AddItemView.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/6/22.
//

import Foundation
import SwiftUI

struct AddItemView: View {
   
    @Binding var isShowing: Bool
    @State private var searchText: String = ""
    @StateObject var viewModel: AddGameItemViewModel
    
    //todo: this should come from the user
    let isUserPremium: Bool = false
 
    
    var body: some View {
        NavigationView {
            VStack {
                if isUserPremium {
                    Text("Searching for \(self.searchText)")
                        .searchable(text: $searchText)
                    Spacer()
                } else {
                    if let item = self.viewModel.gameItem {
                        Text("item added \(item.title)")
                        Button("Done") {
                            let _ = print("this shouldnt be called")
                            self.isShowing = false
                        }
                        Spacer()
                    } else {
                        TextField("Title", text: self.$viewModel.title, prompt: nil)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                        Divider()
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                        TextEditor(text: self.$viewModel.notes)
                            .border(.black, width: 1)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                        Spacer()
                    }
                    
                }
            }.toolbar(content: {
                ToolbarItemGroup(placement: .cancellationAction, content: {
                    Button("Dismiss") {
                        self.isShowing = false
                    }
                })
                ToolbarItemGroup(placement: .destructiveAction) {
                    Button("Save") {
                        self.viewModel.addItem()
                    }
                }
            }).navigationTitle("Add Item")
        }
    }
}
