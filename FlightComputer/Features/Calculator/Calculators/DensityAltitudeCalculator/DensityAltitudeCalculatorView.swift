//
//  DensityAltitudeCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

import SwiftUI

struct DensityAltitudeCalculatorView: View {
    @State var vm = DensityAltitudeCalculatorViewModel()
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
            pressureAltitude
            trueAltitude
            oat
        }
    }

    var computedResults: some View {
        VStack {
            isaTemp
            densityAltitude
        }
    }

    var pressureAltitude: some View {
        VStack {
            CustomTextFieldView(title: "Pressure Altitude", value: $vm.calculator.pressureAltitude, placeHolder: "Pressure Altitude", unit: vm.calculator.pressureAltitudeUnit.symbol)
            Picker("Pressure Altitude Unit", selection: $vm.calculator.pressureAltitudeUnit) {
                ForEach(Distance.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        .focused($focused, equals: .pressureAltitude)
        .onSubmit {
            focused?.next()
        }
    }
    
    var trueAltitude: some View {
        CustomTextFieldView(title: "True Altitude", value: $vm.calculator.trueAltitude, placeHolder: "True Altitude", unit: vm.calculator.pressureAltitudeUnit.symbol)
            .focused($focused, equals: .trueAltitude)
            .onSubmit {
                focused?.next()
            }
       
    }

    var oat: some View {
        VStack {
            CustomTextFieldView(title: "Outside Air Temperature", value: $vm.calculator.oat, placeHolder: "OAT", unit: vm.calculator.oatUnit.symbol)
            Picker("OAT Unit", selection: $vm.calculator.oatUnit) {
                ForEach(Temperature.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        .focused($focused, equals: .oat)
        .onSubmit {
            focused?.next()
        }
    }

    var isaTemp: some View {
        CustomTextView(title: "ISA Temperature", value: vm.calculator.isaTemp, unit: vm.calculator.oatUnit.symbol)
    }

    var densityAltitude: some View {
        CustomTextView(title: "Density Altitude", value: vm.calculator.densityAltitude, unit: vm.calculator.pressureAltitudeUnit.symbol)
    }
}

extension DensityAltitudeCalculatorView {
    enum FocusField {
        case pressureAltitude, trueAltitude, oat, notFocused
        
        mutating func next() {
            switch self {
                
            case .pressureAltitude:
                self = .trueAltitude
            case .trueAltitude:
                self = .oat
            case .oat:
                self = .notFocused
            default:
                self = .pressureAltitude
            }
        }
    }
}

#Preview {
//    @Previewable @State var vm = DensityAltitudeCalculatorViewModel()
    DensityAltitudeCalculatorView()
}
