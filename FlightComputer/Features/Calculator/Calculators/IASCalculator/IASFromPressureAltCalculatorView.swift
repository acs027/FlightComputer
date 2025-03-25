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
        CustomTextFieldView(title: "Pressure Altitude", value: $vm.fromPressureAltCalculator.pressureAltitude, placeHolder: "Altitude (m)")
            .focused($focused, equals: .pressureAltitude)
            .onSubmit {
                focused = focused?.next()
            }
    }

    var outsideAirTemp: some View {
        CustomTextFieldView(title: "Outside Air Temperature", value: $vm.fromPressureAltCalculator.outsideAirTemp, placeHolder: "OAT (°C)")
            .focused($focused, equals: .outsideAirTemp)
            .onSubmit {
                focused = focused?.next()
            }
    }

    var trueAirSpeed: some View {
        CustomTextFieldView(title: "True Air Speed", value: $vm.fromPressureAltCalculator.trueAirSpeed, placeHolder: "TAS (knots)")
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

