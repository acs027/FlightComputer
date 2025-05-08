//
//  FlightComputerApp.swift
//  FlightComputer
//
//  Created by ali cihan on 9.02.2025.
//

import SwiftUI

@main
struct FlightComputerApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = true
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var adManager = InterstitialAdManager()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(adManager)
            .fullScreenCover(isPresented: $hasSeenOnboarding) {
                OnboardingView()
            }
        }
    }
}
