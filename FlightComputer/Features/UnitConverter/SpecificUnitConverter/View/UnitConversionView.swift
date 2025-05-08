//
//  UnitConversionView.swift
//  FlightComputer
//
//  Created by ali cihan on 10.02.2025.
//

import SwiftUI

struct UnitConversionView: View {
    @Bindable var viewModel: UnitConversionViewModel
    @Environment(\.dismiss) var dismiss
    let gridItems = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            conversionView
                .padding()
            Spacer()
            NumPad(inputText: $viewModel.numPadInput, value: $viewModel.value, swapFunction: { swapUnits()})
        }
        .animation(.easeInOut, value: viewModel.selectedConversion)
        .background(Color(.systemGroupedBackground))
        .navigationTitle(viewModel.selectedConversion.rawValue)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
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
        case .speed:
            speedConversion
        }
    }
    
    var volumeConversion: some View {
        VStack {
            TwoUnitsConversionView(
                mainUnit: $viewModel.unitConversion.volumeUnit,
                toUnit: $viewModel.unitConversion.toVolumeUnit,
                units: Array(Volume.allCases),
                value: $viewModel.unitConversion.volumeValue,
                inputText: viewModel.numPadInput
            )
        }
    }
    
    var areaConversion: some View {
        VStack {
            TwoUnitsConversionView(
                mainUnit: $viewModel.unitConversion.areaUnit,
                toUnit: $viewModel.unitConversion.toAreaUnit,
                units: Array(Area.allCases),
                value: $viewModel.unitConversion.areaValue,
                inputText: viewModel.numPadInput
            )
        }
    }
    
    var distanceConversion: some View {
        VStack {
            TwoUnitsConversionView(
                mainUnit: $viewModel.unitConversion.distanceUnit,
                toUnit: $viewModel.unitConversion.toDistanceUnit,
                units: Array(Distance.allCases),
                value: $viewModel.unitConversion.distanceValue,
                inputText: viewModel.numPadInput
            )
        }
    }
    
    var massConversion: some View {
        VStack {
            TwoUnitsConversionView(
                mainUnit: $viewModel.unitConversion.massUnit,
                toUnit: $viewModel.unitConversion.toMassUnit,
                units: Array(Mass.allCases),
                value: $viewModel.unitConversion.massValue,
                inputText: viewModel.numPadInput
            )
        }
    }
    
    var pressureConversion: some View {
        VStack {
            TwoUnitsConversionView(
                mainUnit: $viewModel.unitConversion.pressureUnit,
                toUnit: $viewModel.unitConversion.toPressureUnit,
                units: Array(Pressure.allCases),
                value: $viewModel.unitConversion.pressureValue,
                inputText: viewModel.numPadInput
            )
        }
    }
    
    var temperatureConversion: some View {
        VStack {
            TwoUnitsConversionView(
                mainUnit: $viewModel.unitConversion.temperatureUnit,
                toUnit: $viewModel.unitConversion.toTemperatureUnit,
                units: Array(Temperature.allCases),
                value: $viewModel.unitConversion.temperatureValue,
                inputText: viewModel.numPadInput
            )
        }
    }
    
    var speedConversion: some View {
        VStack {
            TwoUnitsConversionView(
                mainUnit: $viewModel.unitConversion.speedUnit,
                toUnit: $viewModel.unitConversion.toSpeedUnit,
                units: Array(Speed.allCases),
                value: $viewModel.unitConversion.speedValue,
                inputText: viewModel.numPadInput
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
