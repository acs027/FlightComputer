//
//  MainTabView.swift
//  FlightComputer
//
//  Created by ali cihan on 18.02.2025.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case unitConverter = "Unit Converter"
    case windCalculator = "Wind Calculator"
    
    var systemImage: String {
        switch self {
        case .unitConverter:
            return "arrow.2.squarepath"
        case .windCalculator:
            return "wind"
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .unitConverter
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                NavigationStack {
                    UnitConversionView()
                }
                .tabItem {
                    Label(Tab.unitConverter.rawValue,
                          systemImage: Tab.unitConverter.systemImage)
                }
                .tag(Tab.unitConverter)
                
                NavigationStack {
                    WindSideView()
                }
                .tabItem {
                    Label(Tab.windCalculator.rawValue,
                          systemImage: Tab.windCalculator.systemImage)
                }
                .tag(Tab.windCalculator)
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.indigo, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    MainTabView()
}
