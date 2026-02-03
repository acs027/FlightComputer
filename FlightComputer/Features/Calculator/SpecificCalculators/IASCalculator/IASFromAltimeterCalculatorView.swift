//
//  IASFromAltimeterCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

struct IASFromAltimeterCalculatorView: View {
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
            indicatedAltitude
            altimeterSetting
            outsideAirTemp
            trueAirSpeed
        }
    }

    var computedResults: some View {
        VStack {
            indicatedAirSpeed
            pressureAltitude
            densityAltitude
        }
    }

    var indicatedAltitude: some View {
        CustomTextFieldView<FocusField>(title: "Indicated Altitude", value: $vm.fromAltimeterCalculator.indicatedAltitude, focus: $focused, field: .indicatedAltitude, placeHolder: "Altitude (ft or m)", unit: vm.fromAltimeterCalculator.altitudeUnit.symbol)
            .focused($focused, equals: .indicatedAltitude)
            .onSubmit {
                focused = focused?.next()
            }
    }

    var altimeterSetting: some View {
        CustomTextFieldView<FocusField>(title: "Altimeter Setting", value: $vm.fromAltimeterCalculator.altimeterSetting, focus: $focused, field: .altimeterSetting, placeHolder: "Setting (inHg or hPa)", unit: vm.fromAltimeterCalculator.altimeterUnit.symbol)
            .focused($focused, equals: .altimeterSetting)
            .onSubmit {
                focused = focused?.next()
            }
    }

    var outsideAirTemp: some View {
        CustomTextFieldView<FocusField>(title: "Outside Air Temperature", value: $vm.fromAltimeterCalculator.outsideAirTemp, focus: $focused, field: .outsideAirTemp, placeHolder: "Temperature (°C)", unit: vm.fromAltimeterCalculator.temperatureUnit.symbol)
            .focused($focused, equals: .outsideAirTemp)
            .onSubmit {
                focused = focused?.next()
            }
    }

    var trueAirSpeed: some View {
        CustomTextFieldView<FocusField>(title: "True Air Speed", value: $vm.fromAltimeterCalculator.trueAirSpeed, focus: $focused, field: .trueAirSpeed, placeHolder: "TAS (knots)", unit: vm.fromAltimeterCalculator.tasUnit.symbol)
            .focused($focused, equals: .trueAirSpeed)
            .onSubmit {
                focused = focused?.next()
            }
    }

    var indicatedAirSpeed: some View {
        CustomTextView(title: "Indicated Air Speed", value: vm.fromAltimeterCalculator.indicatedAirSpeed, unit: vm.fromAltimeterCalculator.tasUnit.symbol)
    }
    
    var pressureAltitude: some View {
        CustomTextView(title: "Pressure Altitude", value: vm.fromAltimeterCalculator.pressureAltitude, unit: vm.fromAltimeterCalculator.altitudeUnit.symbol)
    }
    
    var densityAltitude: some View {
        CustomTextView(title: "Density Altitude", value: vm.fromAltimeterCalculator.densityAltitude, unit: vm.fromAltimeterCalculator.altitudeUnit.symbol)
    }
}

extension IASFromAltimeterCalculatorView {
    enum FocusField {
        case indicatedAltitude, altimeterSetting, outsideAirTemp, trueAirSpeed
        
        func next() -> FocusField? {
            switch self {
            case .indicatedAltitude:
                return .altimeterSetting
            case .altimeterSetting:
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
    IASFromAltimeterCalculatorView(vm: vm)
}
