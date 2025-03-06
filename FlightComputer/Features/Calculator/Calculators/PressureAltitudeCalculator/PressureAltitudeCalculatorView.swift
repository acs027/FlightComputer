//
//  PressureAltitudeCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

struct PressureAltitudeCalculatorView: View {
    @State var vm = PressureAltitudeCalculatorViewModel()
    @FocusState var focused: FocusField?
    
    var body: some View {
        ScrollView {
            VStack {
                userInputs
                computedResults
            }
        }
    }

    var userInputs: some View {
        VStack {
            altimeterSetting
            fieldElevation
        }
    }

    var computedResults: some View {
        VStack {
            pressureAltitude
        }
    }

    var altimeterSetting: some View {
        VStack {
            CustomTextFieldView(title: "Altimeter Setting", value: $vm.calculator.altimeterSetting, placeHolder: "Altimeter Setting", unit: vm.calculator.altimeterSettingUnit.symbol)
            Picker("Altimeter Unit", selection: $vm.calculator.altimeterSettingUnit) {
                ForEach(Pressure.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        .focused($focused, equals: .altimeterSetting)
        .onSubmit {
            focused?.next()
        }
    }

    var fieldElevation: some View {
        VStack {
            CustomTextFieldView(title: "Field Elevation", value: $vm.calculator.fieldElevation, placeHolder: "Field Elevation", unit: vm.calculator.fieldElevationUnit.symbol)
            Picker("Field Elevation Unit", selection: $vm.calculator.fieldElevationUnit) {
                ForEach(Distance.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        .focused($focused, equals: .fieldElevation)
        .onSubmit {
            focused?.next()
        }
    }

    var pressureAltitude: some View {
        CustomTextView(title: "Pressure Altitude", value: vm.calculator.pressureAltitude, unit: vm.calculator.fieldElevationUnit.symbol)
    }
}

extension PressureAltitudeCalculatorView {
    enum FocusField {
        case altimeterSetting, fieldElevation, notFocused
        
        mutating func next() {
            switch self {
                
            case .altimeterSetting:
                self = .fieldElevation
            case .fieldElevation:
                self = .notFocused
            default:
                self = .altimeterSetting
            }
        }
    }
}

#Preview {
//    @Previewable @State var vm = PressureAltitudeCalculatorViewModel()
    PressureAltitudeCalculatorView()
}
