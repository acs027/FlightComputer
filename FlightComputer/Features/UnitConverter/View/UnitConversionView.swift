//
//  UnitConversionView.swift
//  FlightComputer
//
//  Created by ali cihan on 10.02.2025.
//

import SwiftUI

struct UnitConversionView: View {
//    @State var viewModel = UnitConversionViewModel()
//    @Environment(UnitConversionViewModel.self) var viewModel
    @Bindable var viewModel: UnitConversionViewModel
    let gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
//            segmentedPicker
            conversionView
                .padding(5)
            Spacer()
            NumPad(value: $viewModel.value, swapFunction: { swapUnits()})
        }
        .animation(.easeInOut, value: viewModel.selectedConversion)
        .background(Color(.systemGroupedBackground))
    }
    
    @ViewBuilder
    var segmentedPicker: some View {
        Picker("Conversion Type", selection: $viewModel.selectedConversion) {
            ForEach(ConversionType.allCases, id: \.self) {
                type in
                Text(type.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .frame(height: 50, alignment: .bottom)
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
        VStack {
            TwoUnitsConversion(
                mainUnit: $viewModel.unitConversion.volumeUnit,
                toUnit: $viewModel.unitConversion.toVolumeUnit,
                units: Array(UnitConversion.Volume.allCases),
                value: $viewModel.unitConversion.volumeValue
            )
        }
    }
    
    var areaConversion: some View {
        VStack {
            TwoUnitsConversion(
                mainUnit: $viewModel.unitConversion.areaUnit,
                toUnit: $viewModel.unitConversion.toAreaUnit,
                units: Array(UnitConversion.Area.allCases),
                value: $viewModel.unitConversion.areaValue
            )
        }
    }
    
    var distanceConversion: some View {
        VStack {
            TwoUnitsConversion(
                mainUnit: $viewModel.unitConversion.distanceUnit,
                toUnit: $viewModel.unitConversion.toDistanceUnit,
                units: Array(UnitConversion.Distance.allCases),
                value: $viewModel.unitConversion.distanceValue
            )
        }
    }
    
    var massConversion: some View {
        VStack {
            TwoUnitsConversion(
                mainUnit: $viewModel.unitConversion.massUnit,
                toUnit: $viewModel.unitConversion.toMassUnit,
                units: Array(UnitConversion.Mass.allCases),
                value: $viewModel.unitConversion.massValue
            )
        }
    }
    
    var pressureConversion: some View {
        VStack {
            TwoUnitsConversion(
                mainUnit: $viewModel.unitConversion.pressureUnit,
                toUnit: $viewModel.unitConversion.toPressureUnit,
                units: Array(UnitConversion.Pressure.allCases),
                value: $viewModel.unitConversion.pressureValue
            )
        }
    }
    
    var temperatureConversion: some View {
        VStack {
            TwoUnitsConversion(
                mainUnit: $viewModel.unitConversion.temperatureUnit,
                toUnit: $viewModel.unitConversion.toTemperatureUnit,
                units: Array(UnitConversion.Temperature.allCases),
                value: $viewModel.unitConversion.temperatureValue
            )
        }
    }
    
    func swapUnits() {
        viewModel.swapUnits()
    }
}

//#Preview {
//    UnitConversionView()
//}
