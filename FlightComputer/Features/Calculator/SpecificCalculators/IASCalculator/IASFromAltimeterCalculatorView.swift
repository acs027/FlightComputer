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
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    focused = nil
                }
            }
        }
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
        }
    }

    var indicatedAltitude: some View {
        CustomTextFieldView(title: "Indicated Altitude", value: $vm.fromAltimeterCalculator.indicatedAltitude, placeHolder: "Altitude (ft or m)")
            .focused($focused, equals: .indicatedAltitude)
            .onSubmit {
                focused = focused?.next()
            }
    }

    var altimeterSetting: some View {
        CustomTextFieldView(title: "Altimeter Setting", value: $vm.fromAltimeterCalculator.altimeterSetting, placeHolder: "Setting (inHg or hPa)")
            .focused($focused, equals: .altimeterSetting)
            .onSubmit {
                focused = focused?.next()
            }
    }

    var outsideAirTemp: some View {
        CustomTextFieldView(title: "Outside Air Temperature", value: $vm.fromAltimeterCalculator.outsideAirTemp, placeHolder: "Temperature (°C)")
            .focused($focused, equals: .outsideAirTemp)
            .onSubmit {
                focused = focused?.next()
            }
    }

    var trueAirSpeed: some View {
        CustomTextFieldView(title: "True Air Speed", value: $vm.fromAltimeterCalculator.trueAirSpeed, placeHolder: "TAS (knots)")
            .focused($focused, equals: .trueAirSpeed)
            .onSubmit {
                focused = focused?.next()
            }
    }

    var indicatedAirSpeed: some View {
        CustomTextView(title: "Indicated Air Speed", value: vm.fromAltimeterCalculator.indicatedAirSpeed)
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
