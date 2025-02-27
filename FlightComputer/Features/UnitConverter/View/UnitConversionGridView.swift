//
//  UnitConversionCatalog.swift
//  FlightComputer
//
//  Created by ali cihan on 23.02.2025.
//

import SwiftUI

struct UnitConversionCatalog: View {
    @State private var viewModel = UnitConversionViewModel()
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
        UnitConversionCatalog()
    }
}
