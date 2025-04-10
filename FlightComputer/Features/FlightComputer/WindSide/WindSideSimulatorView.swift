//
//  WindSideSimulatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 12.03.2025.
//

import SwiftUI

struct WindSideSimulatorView: View {
    @State var isProMode: Bool = false
    @EnvironmentObject var adManager: InterstitialAdManager
    
    var body: some View {
        ZStack {
            if isProMode {
                WindSideProView()
            } else {
                WindSideView()
            }
            VStack {
                HStack {
                    switchModeButton
                    Spacer()
                }
                Spacer()
            }
            .padding(20)
        }
        .frame(maxHeight: .infinity)
        .onChange(of: isProMode) { oldValue, newValue in
            adManager.showAd()
        }
    }
    
    var switchModeButton: some View {
        CircleButton(function: handleModeChange, tint: Color(.tertiarySystemBackground), title: isProMode ? "Pro" : "N")
    }
    
    private func handleModeChange() {
        isProMode.toggle()
    }
}

#Preview {
    WindSideSimulatorView()
}
