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
                focused?.next()
            }
    }

    var outsideAirTemp: some View {
        CustomTextFieldView(title: "Outside Air Temperature", value: $vm.fromPressureAltCalculator.outsideAirTemp, placeHolder: "OAT (°C)")
            .focused($focused, equals: .outsideAirTemp)
            .onSubmit {
                focused?.next()
            }
    }

    var trueAirSpeed: some View {
        CustomTextFieldView(title: "True Air Speed", value: $vm.fromPressureAltCalculator.trueAirSpeed, placeHolder: "TAS (knots)")
            .focused($focused, equals: .trueAirSpeed)
            .onSubmit {
                focused?.next()
            }
    }

    var indicatedAirSpeed: some View {
        CustomTextView(title: "Indicated Air Speed", value: vm.fromPressureAltCalculator.indicatedAirSpeed)
    }
}

extension IASFromPressureAltCalculatorView {
    enum FocusField {
        case pressureAltitude, outsideAirTemp, trueAirSpeed, notFocused
        
        mutating func next() {
            switch self {
            case .pressureAltitude:
                self = .outsideAirTemp
            case .outsideAirTemp:
                self = .trueAirSpeed
            case .trueAirSpeed:
                self = .notFocused
            default:
                self = .pressureAltitude
            }
        }
    }
}

#Preview {
    @Previewable @State var vm = IASCalculatorViewModel()
    IASFromPressureAltCalculatorView(vm: vm)
}

