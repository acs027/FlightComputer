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
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .fullScreenCover(isPresented: $hasSeenOnboarding) {
                    OnboardingView()
                }
        }
    }
}
