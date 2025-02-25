//
//  IASFromAltimeterCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

struct IASFromAltimeterCalculatorView: View {
    @Bindable var vm: IASCalculatorViewModel

    var body: some View {
        VStack {
            userInputs
            computedResults
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
    }

    var altimeterSetting: some View {
        CustomTextFieldView(title: "Altimeter Setting", value: $vm.fromAltimeterCalculator.altimeterSetting, placeHolder: "Setting (inHg or hPa)")
    }

    var outsideAirTemp: some View {
        CustomTextFieldView(title: "Outside Air Temperature", value: $vm.fromAltimeterCalculator.outsideAirTemp, placeHolder: "Temperature (°C)")
    }

    var trueAirSpeed: some View {
        CustomTextFieldView(title: "True Air Speed", value: $vm.fromAltimeterCalculator.trueAirSpeed, placeHolder: "TAS (knots)")
    }

    var indicatedAirSpeed: some View {
        CustomTextView(title: "Indicated Air Speed", value: vm.fromAltimeterCalculator.indicatedAirSpeed)
    }
}

#Preview {
    @Previewable @State var vm = IASCalculatorViewModel()
    IASFromAltimeterCalculatorView(vm: vm)
}
