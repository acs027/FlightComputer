//
//  AppDelegate.swift
//  FlightComputer
//
//  Created by ali cihan on 25.03.2025.
//

import SwiftUI
import GoogleMobileAds

class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    MobileAds.shared.start(completionHandler: nil)

    return true
  }
}

//@main
//struct FlightComputerApp: App {
//  // To handle app delegate callbacks in an app that uses the SwiftUI lifecycle,
//  // you must create an application delegate and attach it to your `App` struct
//  // using `UIApplicationDelegateAdaptor`.
//  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//
//  var body: some Scene {
//    WindowGroup {
//      NavigationView {
//          VStack {
//              Color.black
//              Spacer()
////              AdBannerView(adUnitID: "ca-app-pub-3940256099942544/2435281174")
////                  .frame(height: 50)
//              BannerContentView(navigationTitle: "Banner")
//                  .frame(height: 50)
//          }
//      }
//    }
//  }
//}
