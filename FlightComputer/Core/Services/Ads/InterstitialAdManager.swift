//
//  InterstetialContentViewModel.swift
//  FlightComputer
//
//  Created by ali cihan on 25.03.2025.
//

import Foundation
import GoogleMobileAds
import AppTrackingTransparency
import UserMessagingPlatform

class InterstitialAdManager: NSObject, FullScreenContentDelegate, ObservableObject {
    private var interstitialAd: InterstitialAd?
    private let cooldown: TimeInterval = 200 // Seconds
    private var lastAdDate: TimeInterval = Date.now.timeIntervalSinceReferenceDate
    private var timer: Timer?
    private let isTest: Bool = false
    
    private var adUnitID: String = ""
    
    
    private var isCooldownOver: Bool {
        Date.now.timeIntervalSinceReferenceDate - lastAdDate > cooldown
    }
    
    override init() {
        super.init()
        startCooldownTimer()
        if let adID = Bundle.main.object(forInfoDictionaryKey: "InterstitialAdUnitID") as? String,
           !isTest{
            self.adUnitID = adID
        } else {
            self.adUnitID = "ca-app-pub-3940256099942544/4411468910"
        }
    }
    
    private func startCooldownTimer() {
        timer?.invalidate()  // Ensure only one timer runs at a time
        timer = Timer.scheduledTimer(withTimeInterval: 20, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.isCooldownOver && self.interstitialAd == nil {
                Task {
                    await self.loadAd()
                }
            }
        }
    }
    
    func loadAd() async {
        if isCooldownOver,
           ConsentInformation.shared.canRequestAds {
            let request = Request()
            if ATTrackingManager.trackingAuthorizationStatus != .authorized {
                let extras = Extras()
                extras.additionalParameters = ["npa": "1"]
                request.register(extras)
            }
            do {
                interstitialAd = try await InterstitialAd.load(
                    with: self.adUnitID, request: Request())
                // [START set_the_delegate]
                interstitialAd?.fullScreenContentDelegate = self
                // [END set_the_delegate]
                timer?.invalidate()
                debugPrint("loaded")
            } catch {
                debugPrint("Failed to load interstitial ad with error: \(error.localizedDescription)")
            }
        }
    }
    // [END load_ad]
    
    // [START show_ad]
    func showAd() {
        guard let interstitialAd = interstitialAd else {
            return
        }
        interstitialAd.present(from: nil)
    }
    // [END show_ad]
    
    // MARK: - GADFullScreenContentDelegate methods
    
    // [START ad_events]
    //  func adDidRecordImpression(_ ad: FullScreenPresentingAd) {
    //    print("\(#function) called")
    //  }
    //
    //  func adDidRecordClick(_ ad: FullScreenPresentingAd) {
    //    print("\(#function) called")
    //  }
    
    //  func ad(
    //    _ ad: FullScreenPresentingAd,
    //    didFailToPresentFullScreenContentWithError error: Error
    //  ) {
    //
    //  }
    
    //  func adWillPresentFullScreenContent(_ ad: FullScreenPresentingAd) {
    //    print("\(#function) called")
    //  }
    //
    //  func adWillDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
    //    print("\(#function) called")
    //  }
    
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        //    print("\(#function) called")
        // Clear the interstitial ad.
        lastAdDate = Date.now.timeIntervalSinceReferenceDate
        interstitialAd = nil
        startCooldownTimer()
    }
    // [END ad_events]
}
