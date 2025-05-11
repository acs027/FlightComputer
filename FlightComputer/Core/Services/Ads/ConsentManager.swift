//
//  ConsentManager.swift
//  FlightComputer
//
//  Created by ali cihan on 10.05.2025.
//
import Foundation
import GoogleMobileAds
import UserMessagingPlatform

@MainActor
class ConsentManager: NSObject {
  static let shared = ConsentManager()
  var isMobileAdsStartCalled = false

  var canRequestAds: Bool {
    return ConsentInformation.shared.canRequestAds
  }

  var isPrivacyOptionsRequired: Bool {
    return ConsentInformation.shared.privacyOptionsRequirementStatus == .required
  }

  /// Helper method to call the UMP SDK methods to request consent information and load/present a
  /// consent form if necessary.
  func gatherConsent(consentGatheringComplete: @escaping (Error?) -> Void) {
    let parameters = RequestParameters()

    // For testing purposes, you can use UMPDebugGeography to simulate a location.
    let debugSettings = DebugSettings()
      debugSettings.geography = DebugGeography.EEA
    parameters.debugSettings = debugSettings

    // [START request_consent_info_update]
    // Requesting an update to consent information should be called on every app launch.
    ConsentInformation.shared.requestConsentInfoUpdate(with: parameters) {
      requestConsentError in
      // [START_EXCLUDE]
      guard requestConsentError == nil else {
        return consentGatheringComplete(requestConsentError)
      }

      Task { @MainActor in
        do {
          // [START load_and_present_consent_form]
          try await ConsentForm.loadAndPresentIfRequired(from: nil)
          // [END load_and_present_consent_form]
          // Consent has been gathered.
          consentGatheringComplete(nil)
        } catch {
          consentGatheringComplete(error)
        }
      }
      // [END_EXCLUDE]
    }
    // [END request_consent_info_update]
  }

  /// Helper method to call the UMP SDK method to present the privacy options form.
  @MainActor func presentPrivacyOptionsForm() async throws {
    // [START present_privacy_options_form]
    try await ConsentForm.presentPrivacyOptionsForm(from: nil)
    // [END present_privacy_options_form]
  }

  /// Method to initialize the Google Mobile Ads SDK. The SDK should only be initialized once.
  func startGoogleMobileAdsSDK() {
    guard canRequestAds, !isMobileAdsStartCalled else { return }
      debugPrint("ads start")
    isMobileAdsStartCalled = true
      print(ConsentInformation.shared.consentStatus.rawValue)
      print(ConsentInformation.shared.formStatus.rawValue)
    // Initialize the Google Mobile Ads SDK.
    MobileAds.shared.start()
  }
}
