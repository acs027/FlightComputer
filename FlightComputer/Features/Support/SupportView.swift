//
//  SupportView.swift
//  FlightComputer
//
//  Created by ali cihan on 6.01.2026.
//

import SwiftUI
import StoreKit

struct SupportView: View {
    var body: some View {
        ZStack {
            Color(.secondarySystemBackground)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Enjoying the App?")
                    .font(.headline)

                Text("If you'd like to support my work, a follow or a review means the world to me!")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                VStack(spacing: 12) {
                    // App Store Review
                    SupportButton(title: "Rate on App Store", icon: "star.fill", color: .orange) {
                        requestReview()
                    }

                    // LinkedIn Follow
                    SupportButton(title: "Follow on LinkedIn", icon: "person.badge.plus", color: .blue) {
                        if let url = URL(string: "https://www.linkedin.com/in/alicihansarac") {
                                        UIApplication.shared.open(url)
                                    }
                    }
                }
            }
            .padding()
        }
    }
    
    @MainActor
    func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            AppStore.requestReview(in: scene)
        }
    }
}









#Preview {
    SupportView()
}
