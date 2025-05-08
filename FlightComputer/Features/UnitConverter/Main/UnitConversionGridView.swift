//
//  UnitConversionCatalog.swift
//  FlightComputer
//
//  Created by ali cihan on 23.02.2025.
//

import SwiftUI

struct UnitConversionGridView: View {
    @State private var viewModel = UnitConversionViewModel()
    @EnvironmentObject var adManager: InterstitialAdManager
    let gridItems = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: gridItems) {
            ForEach(ConversionType.allCases, id: \.rawValue) { type in
                unitTypeLabel(type: type)
                        .onTapGesture {
                            viewModel.selectedConversion = type
                            viewModel.isConversionViewShowing.toggle()
                        }
            }
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationDestination(isPresented: $viewModel.isConversionViewShowing) {
            UnitConversionView(viewModel: viewModel)
        }
        .navigationTitle("Unit Conversion")
        .onChange(of: viewModel.selectedConversion) { oldValue, newValue in
            adManager.showAd()
        }
        .overlay {
            ZStack(alignment: .bottom) {
                Color.clear
                privacyPolicyButton
            }
            .padding()
        }
    }
    
    private var privacyPolicyButton: some View {
        Button {
            if let url = URL(string: "https://acs027.github.io/E6BFlightPro/privacy") {
                                    UIApplication.shared.open(url)
                                }
        } label: {
            Text("Privacy Policy")
        }
    }
    
    func unitTypeLabel(type: ConversionType) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.gray.gradient)
                .frame(width: 100, height: 100)
                .overlay {
                    Image(systemName: type.systemImage)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            Text(type.rawValue)
        }
    }
    
}

#Preview {
    NavigationStack {
        UnitConversionGridView()
    }
}
