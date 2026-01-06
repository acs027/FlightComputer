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
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    @State var adManager = InterstitialAdManager()
//    private var isMobileAdsStartCalled = false
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
//                .environmentObject(adManager)
                .fullScreenCover(isPresented: $hasSeenOnboarding) {
                    OnboardingView()
                }
//                .onAppear {
//                    ConsentManager.shared.gatherConsent { consentError in
//                        if let consentError {
//                            // Consent gathering failed.
//                            print("Error: \(consentError.localizedDescription)")
//                        }
//                        if ConsentManager.shared.canRequestAds {
//                            ConsentManager.shared.startGoogleMobileAdsSDK()
//                        }
//                    }
//                    if ConsentManager.shared.canRequestAds {
//                        ConsentManager.shared.startGoogleMobileAdsSDK()
//                    }
//                }
        }
    }
}
