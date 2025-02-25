//
//  IASFromPressureAltCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

struct IASFromPressureAltCalculatorView: View {
    @Bindable var vm: IASCalculatorViewModel

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
    }

    var outsideAirTemp: some View {
        CustomTextFieldView(title: "Outside Air Temperature", value: $vm.fromPressureAltCalculator.outsideAirTemp, placeHolder: "OAT (°C)")
    }

    var trueAirSpeed: some View {
        CustomTextFieldView(title: "True Air Speed", value: $vm.fromPressureAltCalculator.trueAirSpeed, placeHolder: "TAS (knots)")
    }

    var indicatedAirSpeed: some View {
        CustomTextView(title: "Indicated Air Speed", value: vm.fromPressureAltCalculator.indicatedAirSpeed)
    }
}

#Preview {
    @Previewable @State var vm = IASCalculatorViewModel()
    IASFromPressureAltCalculatorView(vm: vm)
}

