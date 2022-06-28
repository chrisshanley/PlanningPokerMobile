//
//  PlanningPokerMobileApp.swift
//  PlanningPokerMobile
//
//  Created by christopher shanley on 11/27/21.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct PlanningPokerMobileApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var errorViewModel: ErrorViewModel = ErrorViewModel()
    
    var bool = true
    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .topLeading, content: {
                ContentView()
                if self.errorViewModel.showError {
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Sorry")
                                    .bold()
                                Text("Looks like we have an error.")
                                    .font(Font.system(size: 15, weight: Font.Weight.light, design: Font.Design.default))
                            }
                            Spacer()
                        }
                        .foregroundColor(Color.white)
                        .padding(8)
                        .background(.red)
                        .cornerRadius(5)
                        
                        Spacer()
                    }
                    .zIndex(1)
                    .padding()
                    .animation(.easeInOut)
                    .transition(AnyTransition.move(edge: .top))
                    
                }
            })
            .environmentObject(self.errorViewModel)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
                case .active:
                    break
                case .background:
                    break
                case .inactive:
                    break
                default:
                    break
            }
        }
    }
}
