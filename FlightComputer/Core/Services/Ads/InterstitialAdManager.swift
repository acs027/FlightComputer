//
//  InterstetialContentViewModel.swift
//  FlightComputer
//
//  Created by ali cihan on 25.03.2025.
//

import Foundation
import GoogleMobileAds

class InterstitialAdManager: NSObject, FullScreenContentDelegate, ObservableObject {
  private var interstitialAd: InterstitialAd?
    private let cooldown: TimeInterval = 60 // Seconds
    private var lastAdDate: TimeInterval = Date.now.timeIntervalSinceReferenceDate
    private var timer: Timer?
    
    private var isCooldownOver: Bool {
        Date.now.timeIntervalSinceReferenceDate - lastAdDate > cooldown
    }
    
    override init() {
            super.init()
            startCooldownTimer()
        }

    private func startCooldownTimer() {
        timer?.invalidate()  // Ensure only one timer runs at a time
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.isCooldownOver && self.interstitialAd == nil {
                Task {
                    await self.loadAd()
                }
            }
        }
    }

  func loadAd() async {
      if isCooldownOver {
        do {
            print("loading")
          interstitialAd = try await InterstitialAd.load(
            with: "ca-app-pub-3940256099942544/4411468910", request: Request())
          // [START set_the_delegate]
          interstitialAd?.fullScreenContentDelegate = self
          // [END set_the_delegate]
            timer?.invalidate()
        } catch {
          print("Failed to load interstitial ad with error: \(error.localizedDescription)")
        }
    }
  }
  // [END load_ad]

  // [START show_ad]
  func showAd() {
    guard let interstitialAd = interstitialAd else {
      return print("Ad wasn't ready.")
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

  func ad(
    _ ad: FullScreenPresentingAd,
    didFailToPresentFullScreenContentWithError error: Error
  ) {
    print("\(#function) called")
  }

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
