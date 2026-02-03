//
//  IASFromPressureAltCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

struct IASFromPressureAltCalculatorView: View {
    @Bindable var vm: IASCalculatorViewModel
    @FocusState var focused: FocusField?

    var body: some View {
        VStack {
            userInputs
            computedResults
        }
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
            pressureAltitude
            outsideAirTemp
            trueAirSpeed
        }
    }

    var computedResults: some View {
        VStack {
            indicatedAirSpeed
        }
    }

    var pressureAltitude: some View {
        VStack {
            CustomTextFieldView<FocusField>(title: "Pressure Altitude", value: $vm.fromPressureAltCalculator.pressureAltitude, focus: $focused, field: .pressureAltitude, placeHolder: "Altitude (m)", unit: vm.fromPressureAltCalculator.altitudeUnit.symbol)
                .focused($focused, equals: .pressureAltitude)
                .onSubmit {
                    focused = focused?.next()
                }
            Picker("Altitude Unit", selection: $vm.fromPressureAltCalculator.altitudeUnit) {
                ForEach(Distance.allCases, id: \.symbol) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
       
    }

    var outsideAirTemp: some View {
        VStack {
            CustomTextFieldView<FocusField>(title: "Outside Air Temperature", value: $vm.fromPressureAltCalculator.outsideAirTemp, focus: $focused, field: .outsideAirTemp, placeHolder: "OAT (°C)", unit: vm.fromPressureAltCalculator.temperatureUnit.symbol)
                .focused($focused, equals: .outsideAirTemp)
                .onSubmit {
                    focused = focused?.next()
                }
            Picker("Outside Air Temperature", selection: $vm.fromPressureAltCalculator.temperatureUnit) {
                ForEach(Temperature.allCases, id: \.symbol) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
    }

    var trueAirSpeed: some View {
        CustomTextFieldView<FocusField>(title: "True Air Speed", value: $vm.fromPressureAltCalculator.trueAirSpeed, focus: $focused, field: .trueAirSpeed, placeHolder: "TAS (knots)")
            .focused($focused, equals: .trueAirSpeed)
            .onSubmit {
                focused = focused?.next()
            }
    }

    var indicatedAirSpeed: some View {
        CustomTextView(title: "Indicated Air Speed", value: vm.fromPressureAltCalculator.indicatedAirSpeed)
    }
}

extension IASFromPressureAltCalculatorView {
    enum FocusField {
        case pressureAltitude, outsideAirTemp, trueAirSpeed
        
        func next() -> FocusField? {
            switch self {
            case .pressureAltitude:
                return .outsideAirTemp
            case .outsideAirTemp:
                return .trueAirSpeed
            case .trueAirSpeed:
                return nil
            }
        }
    }
}

#Preview {
    @Previewable @State var vm = IASCalculatorViewModel()
    IASFromPressureAltCalculatorView(vm: vm)
}

