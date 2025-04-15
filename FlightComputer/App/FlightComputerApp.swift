//
//  FlightComputerApp.swift
//  FlightComputer
//
//  Created by ali cihan on 9.02.2025.
//

import SwiftUI

@main
struct FlightComputerApp: App {
//    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = true
    @State var hasSeenOnboarding: Bool = true
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var isAdsShowed: Bool = false
    @State var adManager = InterstitialAdManager()
    @State var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if networkMonitor.hasNetworkConnection {
                    BannerContentView(navigationTitle: "Banner")
                        .frame(width: 320, height: 50)
                    Spacer()
                } else {
                    Color.clear
                        .frame(width: 320, height: 50)
                }
                MainTabView()
                    .environmentObject(adManager)
            }
            .fullScreenCover(isPresented: $hasSeenOnboarding) {
                OnboardingView()
            }
        }
    }
}
