//
//  OnboardingPageView.swift
//  FlightComputer
//
//  Created by ali cihan on 26.02.2025.
//

import SwiftUI

struct OnboardingPageView: View {
    let page: OnboardingPage
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: page.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            Text(page.title)
                .font(.title)
                .multilineTextAlignment(.center)
                .bold()
            Text(page.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
}
