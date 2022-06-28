//
//  VotingView.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 6/8/22.
//

import Foundation
import SwiftUI
struct VotingView: View {
    
    @StateObject var viewModel: VotingViewModel
    @Binding var isShowing: Bool
    
    let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 100)),
        GridItem(.adaptive(minimum: 100, maximum: 100)),	
        GridItem(.adaptive(minimum: 100, maximum: 100))
    ]
    
    func fillColor(value: Int) -> Color {
        var fillColor = Color.white
        if let current = self.viewModel.currentVote, current == value {
            fillColor = .gray
        }
        return fillColor
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text(self.viewModel.item.title)
                if let notes = self.viewModel.item.notes {
                    Text(notes)
                }
                LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                    ForEach(self.viewModel.votingValues, id: \.self) { points in
                       
                        Button {
                            self.viewModel.vote(value: points.value)
                        } label: {
                            Text(points.displayName)
                                .frame(minWidth: 40)
                                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                                .border(.gray, width: 1)
                                .cornerRadius(5)
                                .background(self.fillColor(value: points.value).cornerRadius(5))
                        }
                      
                    }
                }
                Spacer(minLength: 20)
                Text("Current Votes")
                VStack(alignment: .leading) {
                    if self.viewModel.currentVotes.count > 0 {
                        ForEach(self.viewModel.currentVotes, id: \.self) { vote in
                            HStack {
                                Text(vote.displayName).padding(.leading)
                                Spacer()
                                if self.viewModel.isVoteVisible {
                                    Text("\(vote.value)").padding(.trailing)
                                } else {
                                    Text("?").padding(.trailing)
                                }
                            }
                        }
                    }
                }
                Spacer(minLength: 10)
                VStack(alignment: .leading, spacing: 0) {
                    let label =  self.viewModel.isVoteVisible ? "Hide Estimates" : "Show Hand"
                    Button(action: {self.viewModel.showHand()}, label: {ButtonView(label: label)}).padding(.horizontal)
                    
                    Spacer().frame(height: 40)
                    if self.viewModel.isVoteVisible {
                        Text("Average : \(self.viewModel.average)").padding(.leading)
                        Spacer().frame(height: 40)
                        HStack(alignment: VerticalAlignment.top, spacing: 0) {
                            Text("Accepted estimate: ").padding(.leading)
                            Spacer()
                            TextField("Points", text: self.$viewModel.acceptedEstimate).keyboardType(.numberPad)
                        }
                        Button(action: {
                            self.viewModel.endVote()
                            self.isShowing.toggle()
                        }, label: {ButtonView(label: "End Hand")}).padding(.horizontal)
                    }
                }
            }
        }
    }
}
