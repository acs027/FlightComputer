//
//  OnboardingView.swift
//  FlightComputer
//
//  Created by ali cihan on 26.02.2025.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State var vm = OnboardingViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<vm.pages.count, id: \.self) { index in
                    OnboardingPageView(page: vm.pages[index])
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
                if currentPage < vm.pages.count - 1 {
                    currentPage += 1
                } else {
                    dismiss()
                }
            }) {
                Text(currentPage < vm.pages.count - 1 ? "Next" : "Get Started")
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
