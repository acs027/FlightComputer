//
//  UnitConversionView.swift
//  FlightComputer
//
//  Created by ali cihan on 10.02.2025.
//

import SwiftUI

struct UnitConversionView: View {
    @State var viewModel = UnitConversionViewModel()
    let gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            segmentedPicker
            conversionView
                .padding(5)
            Spacer()
            NumPad(value: $viewModel.value)
        }
    }
    
    var segmentedPicker: some View {
        Picker("Conversion Type", selection: $viewModel.selectedConversion) {
            ForEach(ConversionType.allCases, id: \.self) {
                type in
                Text(type.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .frame(alignment: .top)
    }
    
    @ViewBuilder
    var conversionView: some View {
        switch viewModel.selectedConversion {
        case .area:
            areaConversion
        case .distance:
            distanceConversion
        case .mass:
            massConversion
        case .pressure:
            pressureConversion
        case .temperature:
            temperatureConversion
        case .volume:
            volumeConversion
        }
    }
    
    var volumeConversion: some View {
        LazyVGrid(columns: gridItems, spacing: 5) {
            ForEach(UnitConversion.Volume.allCases, id: \.self) { unit in
                UnitConversionTextField(unit: unit, value: $viewModel.unitConversion.volumeValue, currentUnit: $viewModel.unitConversion.volumeUnit)
            }
        }
    }
    
    var areaConversion: some View {
        LazyVGrid(columns: gridItems, spacing: 5) {
            ForEach(UnitConversion.Area.allCases, id: \.self) { unit in
                UnitConversionTextField(unit: unit, value: $viewModel.unitConversion.areaValue, currentUnit: $viewModel.unitConversion.areaUnit)
            }
        }
    }
    
    var distanceConversion: some View {
        LazyVGrid(columns: gridItems, spacing: 5) {
            ForEach(UnitConversion.Distance.allCases, id: \.self) { unit in
                UnitConversionTextField(unit: unit, value: $viewModel.unitConversion.distanceValue, currentUnit: $viewModel.unitConversion.distanceUnit)
            }
        }
    }
    
    var massConversion: some View {
        LazyVGrid(columns: gridItems, spacing: 5) {
            ForEach(UnitConversion.Mass.allCases, id: \.self) { unit in
                UnitConversionTextField(unit: unit, value: $viewModel.unitConversion.massValue, currentUnit: $viewModel.unitConversion.massUnit)
            }
        }
    }
    
    var pressureConversion: some View {
        LazyVGrid(columns: gridItems, spacing: 5) {
            ForEach(UnitConversion.Pressure.allCases, id: \.self) { unit in
                UnitConversionTextField(unit: unit, value: $viewModel.unitConversion.pressureValue, currentUnit: $viewModel.unitConversion.pressureUnit)
            }
        }
    }
    
    var temperatureConversion: some View {
        VStack {
            ForEach(UnitConversion.Temperature.allCases, id: \.self) { unit in
                UnitConversionTextField(unit: unit, value: $viewModel.unitConversion.temperatureValue, currentUnit: $viewModel.unitConversion.temperatureUnit)
            }
        }
    }
}

#Preview {
    UnitConversionView()
}
