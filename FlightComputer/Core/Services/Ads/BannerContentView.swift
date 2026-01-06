//
//  BannerContentView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.03.2025.
//
//
//import GoogleMobileAds
//import SwiftUI
//
//struct BannerContentView: View {
//  let navigationTitle: String
//
//  // [START add_banner_to_view]
//  var body: some View {
//    GeometryReader { geometry in
//      let adSize = currentOrientationAnchoredAdaptiveBanner(width: geometry.size.width)
//
//      VStack {
//        Spacer()
//        BannerViewContainer(adSize)
//          .frame(height: adSize.size.height)
//      }
//    }
//    // [END add_banner_to_view]
////    .navigationTitle(navigationTitle)
//  }
//}
//
//struct BannerContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    BannerContentView(navigationTitle: "Banner")
//  }
//}
//
//// [START create_banner_view]
//private struct BannerViewContainer: UIViewRepresentable {
//  let adSize: AdSize
//
//  init(_ adSize: AdSize) {
//    self.adSize = adSize
//  }
//
//  func makeUIView(context: Context) -> UIView {
//    // Wrap the GADBannerView in a UIView. GADBannerView automatically reloads a new ad when its
//    // frame size changes; wrapping in a UIView container insulates the GADBannerView from size
//    // changes that impact the view returned from makeUIView.
//    let view = UIView()
//    view.addSubview(context.coordinator.bannerView)
//    return view
//  }
//
//  func updateUIView(_ uiView: UIView, context: Context) {
//    context.coordinator.bannerView.adSize = adSize
//  }
//
//  func makeCoordinator() -> BannerCoordinator {
//    return BannerCoordinator(self)
//  }
//  // [END create_banner_view]
//
//  // [START create_banner]
//  class BannerCoordinator: NSObject, BannerViewDelegate {
//      private var isTest: Bool = true
//      private var adUnitID: String = ""
//    private(set) lazy var bannerView: BannerView = {
//      let banner = BannerView(adSize: parent.adSize)
//      // [START load_ad]
//        banner.adUnitID = adUnitID
//      banner.load(Request())
//      // [END load_ad]
//      // [START set_delegate]
//      banner.delegate = self
//      // [END set_delegate]
//      return banner
//    }()
//
//    let parent: BannerViewContainer
//
//    init(_ parent: BannerViewContainer) {
//      self.parent = parent
//        if let adID = Bundle.main.object(forInfoDictionaryKey: "BannerAdUnitID") as? String,
//           !isTest{
//            self.adUnitID = adID
//        } else {
//            self.adUnitID = "ca-app-pub-3940256099942544/2435281174"
//        }
//    }
//    // [END create_banner]
//
//    // MARK: - GADBannerViewDelegate methods
//
//    func bannerViewDidReceiveAd(_ bannerView: BannerView) {
//      print("DID RECEIVE AD.")
//    }
//
//    func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
//      print("FAILED TO RECEIVE AD: \(error.localizedDescription)")
//    }
//  }
//}
