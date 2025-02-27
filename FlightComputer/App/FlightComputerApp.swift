//
//  FlightComputerApp.swift
//  FlightComputer
//
//  Created by ali cihan on 9.02.2025.
//

import SwiftUI

@main
struct FlightComputerApp: App {
    @State var isOnboardingShowing = true
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .fullScreenCover(isPresented: $isOnboardingShowing) {
                    OnboardingView()
                }
        }
    }
}
