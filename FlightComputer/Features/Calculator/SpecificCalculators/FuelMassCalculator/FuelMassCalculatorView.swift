//
//  FuelMassCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 2.02.2026.
//

import SwiftUI

struct FuelMassCalculatorView: View {
    @State var vm = FuelMassCalculatorViewModel()
    @FocusState var focused: FocusField?
    
    var body: some View {
        ScrollView {
            VStack {
                userInputs
                computedResults
            }
        }
        .navigationTitle("Fuel Mass Calculator")
//        .toolbar {
//            ToolbarItemGroup(placement: .keyboard) {
//                Spacer()
//                Button("Done") {
//                    focused = nil
//                }
//            }
//        }
    }
    
    var userInputs: some View {
        VStack {
            fuelTypeUnit
            fuelType
            density
            volumeSection
        }
    }
    
    var computedResults: some View {
        massSection
    }
    
    var fuelTypeUnit: some View {
        Picker("Fuel Density Unit", selection: $vm.fuelMassCalculator.fuelTypeUnit) {
            ForEach(vm.fuelTypeUnits, id:\.self) { fuelTypeUnit in
                Text(fuelTypeUnit.symbol)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    var fuelType: some View {
        Picker("Fuel Type", selection: $vm.fuelMassCalculator.fuelType) {
            ForEach(FuelType.allPresets, id:\.self) { fuelType in
                Text(fuelType.label)
            }
        }
        .pickerStyle(.menu)
        .padding(.horizontal)
    }
    
    @ViewBuilder
    var density: some View {
        if case .other = vm.fuelMassCalculator.fuelType {
            CustomTextFieldView<FocusField>(title: "Density", value: $vm.fuelMassCalculator.density, focus: $focused, field: .density, placeHolder: "Density")
                .focused($focused, equals: .density)
                .onSubmit {
                    focused = focused?.next()
                }
        } else {
            CustomTextView(title: "Density", value: vm.fuelMassCalculator.density, unit: vm.fuelMassCalculator.fuelTypeUnit.symbol)
        }
    }
    
    var volumeSection: some View {
        VStack {
            CustomTextFieldView<FocusField>(title: "Volume", value: $vm.fuelMassCalculator.volume, focus: $focused, field: .volume, placeHolder: "Volume")
                .focused($focused, equals: .volume)
                .onSubmit {
                    focused = focused?.next()
                }
            Picker("Volume Unit", selection: $vm.fuelMassCalculator.volumeUnit) {
                ForEach(Volume.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
     
    }
    
    var massSection: some View {
        VStack {
            Picker("Mass Unit", selection: $vm.fuelMassCalculator.massUnit) {
                ForEach(Mass.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.top)
            CustomTextView(title: "Mass", value: vm.fuelMassCalculator.mass, unit: vm.fuelMassCalculator.massUnit.symbol)
        }
    }
}

extension FuelMassCalculatorView {
    enum FocusField {
        case density, volume
        
        func next() -> FocusField? {
            switch self {
            case .density:
                return .volume
            case .volume:
                return nil
            }
        }
    }
}

#Preview {
    FuelMassCalculatorView()
}
