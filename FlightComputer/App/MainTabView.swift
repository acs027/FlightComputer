//
//  MainTabView.swift
//  FlightComputer
//
//  Created by ali cihan on 18.02.2025.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case unitConverter = "Unit Converter"
    case windCalculator = "WCA Simulator"
    case wcaCalculator = "WCA Calculator"
    case calculator = "Calculator"
    
    var systemImage: String {
        switch self {
        case .unitConverter:
            return "arrow.2.squarepath"
        case .windCalculator:
            return "wind"
        case .wcaCalculator:
            return "angle"
        case .calculator:
            return "plusminus"
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .unitConverter
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                unitConversionView
                windSideView
                wcaCalculator
                calculator
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color(.secondarySystemBackground), for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
    
    var unitConversionView: some View {
        NavigationStack {
            UnitConversionGridView()
        }
        .tabItem {
            Label(Tab.unitConverter.rawValue,
                  systemImage: Tab.unitConverter.systemImage)
        }
        .tag(Tab.unitConverter)
    }
    var windSideView: some View {
        NavigationStack {
            WindSideView()
        }
        .tabItem {
            Label(Tab.windCalculator.rawValue,
                  systemImage: Tab.windCalculator.systemImage)
        }
        .tag(Tab.windCalculator)
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
        }
        .tabItem {
            Label(Tab.calculator.rawValue,
                  systemImage: Tab.calculator.systemImage)
        }
        .tag(Tab.calculator)
    }
}

#Preview {
    MainTabView()
}
