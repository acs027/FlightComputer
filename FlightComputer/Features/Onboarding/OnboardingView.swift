//
//  OnboardingView.swift
//  FlightComputer
//
//  Created by ali cihan on 26.02.2025.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @Environment(\.dismiss) var dismiss
    
    private let pages: [OnboardingPage] = [
        OnboardingPage(image: "airplane", title: "Welcome to E6B Flight Computer", description: "Your go-to tool for aviation calculations."),
        OnboardingPage(image: "speedometer", title: "Accurate Calculations", description: "Compute wind correction, fuel burn, and more."),
        OnboardingPage(image: "gear", title: "Easy to Use", description: "Designed for pilots, with intuitive controls.")
    ]
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    OnboardingPageView(page: pages[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            
            Text("This app is for educational purposes only. Do not rely on the data for real-world applications.")
                .font(.footnote)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                if currentPage < pages.count - 1 {
                    currentPage += 1
                } else {
                    dismiss()
                }
            }) {
                Text(currentPage < pages.count - 1 ? "Next" : "Get Started")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    OnboardingView()
}
