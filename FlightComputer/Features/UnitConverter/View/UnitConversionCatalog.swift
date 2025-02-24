//
//  UnitConversionCatalog.swift
//  FlightComputer
//
//  Created by ali cihan on 23.02.2025.
//

import SwiftUI

struct UnitConversionCatalog: View {
    @State var viewModel = UnitConversionViewModel()
    let gridItems = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: gridItems) {
            ForEach(ConversionType.allCases, id: \.rawValue) { type in
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
                        .onTapGesture {
                            viewModel.selectedConversion = type
                            viewModel.isConversionViewShowing.toggle()
                        }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationDestination(isPresented: $viewModel.isConversionViewShowing) {
            UnitConversionView()
                .environment(viewModel)
        }
        .navigationTitle("Unit Conversion")
    }
    
}

#Preview {
    NavigationStack {
        UnitConversionCatalog()
    }
}
