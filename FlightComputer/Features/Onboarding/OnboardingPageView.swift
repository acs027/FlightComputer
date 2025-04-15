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
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
            Text(page.title)
                .font(.title)
                .minimumScaleFactor(0.7)
                .multilineTextAlignment(.center)
                .bold()
            Text(page.description)
                .font(.body)
                .minimumScaleFactor(0.7)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
}
