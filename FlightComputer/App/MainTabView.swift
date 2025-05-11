//
//  MainTabView.swift
//  FlightComputer
//
//  Created by ali cihan on 18.02.2025.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case unitConverter = "Converters"
    case windSide = "Wind Side"
    case frontSide = "Front Side"
    case wcaCalculator = "Drift"
    case calculator = "Calculator"
    
    var systemImage: String {
        switch self {
        case .unitConverter:
            return "arrow.2.squarepath"
        case .windSide:
            return "wind"
        case .frontSide:
            return "circle.dashed.inset.filled"
        case .wcaCalculator:
            return "angle"
        case .calculator:
            return "plusminus"
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .frontSide
    @EnvironmentObject var adManager: InterstitialAdManager
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                frontSideView
                windSideView
                wcaCalculator
                unitConversionView
                calculator
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color(.secondarySystemBackground), for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
            .onChange(of: selectedTab) { oldValue, newValue in
                adManager.showAd()
            }
        }
    }
    
    
    var unitConversionView: some View {
        NavigationStack {
            UnitConversionGridView()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        settingsMenu
                    }
                }
        }
        .tabItem {
            Label(Tab.unitConverter.rawValue,
                  systemImage: Tab.unitConverter.systemImage)
        }
        .tag(Tab.unitConverter)
    }
    var windSideView: some View {
        NavigationStack {
            WindSideSimulatorView()
        }
        .tabItem {
            Label(Tab.windSide.rawValue,
                  systemImage: Tab.windSide.systemImage)
        }
        .tag(Tab.windSide)
    }
    var wcaCalculator: some View {
        NavigationStack {
            WindCorrectionCalculatorView()
        }
        .tabItem {
            Label(Tab.wcaCalculator.rawValue,
                  systemImage: Tab.wcaCalculator.systemImage)
        }
        .tag(Tab.wcaCalculator)
    }
    var calculator: some View {
        NavigationStack {
            CalculatorListView()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        settingsMenu
                    }
                }
        }
        .tabItem {
            Label(Tab.calculator.rawValue,
                  systemImage: Tab.calculator.systemImage)
        }
        .tag(Tab.calculator)
    }
    
    var frontSideView: some View {
        NavigationStack {
            SlideRuleSideView()
        }
        .tabItem {
            Label(Tab.frontSide.rawValue,
                  systemImage: Tab.frontSide.systemImage)
        }
        .tag(Tab.frontSide)
    }
    
    var settingsMenu: some View {
        Menu {
            Button("Privacy Settings") {
                Task {
                    try await ConsentManager.shared.presentPrivacyOptionsForm()
                }
            }
            Button("Privacy Policy") {
                if let url = URL(string: "https://acs027.github.io/E6BFlightPro/privacy") {
                    UIApplication.shared.open(url)
                }
            }
        } label: {
            Label("Settings", systemImage: "gear")
        }
    }
}

#Preview {
    MainTabView()
}
