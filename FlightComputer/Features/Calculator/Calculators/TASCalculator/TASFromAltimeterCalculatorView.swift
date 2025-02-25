//
//  TASFromAltimeterCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

struct TASFromAltimeterCalculatorView: View {
    @Bindable var vm: TASCalculatorViewModel
    
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
            indicatedAirSpeed
        }
    }
    
    var computedResults: some View {
        VStack {
            trueAirSpeed
        }
    }
    
    var indicatedAltitude: some View {
        CustomTextFieldView(title: "Indicated Altitude", value: $vm.tasFromAltimeterCalculator.indicatedAltitude, placeHolder: "Altitude (ft or m)")
    }
    
    var altimeterSetting: some View {
        CustomTextFieldView(title: "Altimeter Setting", value: $vm.tasFromAltimeterCalculator.altimeterSetting, placeHolder: "Altimeter Setting (in/hg or hpa)")
    }
    
    var outsideAirTemp: some View {
        CustomTextFieldView(title: "Outside Air Temperature", value: $vm.tasFromAltimeterCalculator.outsideAirTemp, placeHolder: "Temperature (°C)")
    }
    
    var indicatedAirSpeed: some View {
        CustomTextFieldView(title: "Indicated Air Speed", value: $vm.tasFromAltimeterCalculator.indicatedAirSpeed, placeHolder: "Indicated Air Speed (IAS) (knots)")
    }
    
    var trueAirSpeed: some View {
        CustomTextView(title: "True Air Speed", value: vm.tasFromAltimeterCalculator.trueAirSpeed)
    }
}

#Preview {
    @Previewable @State var vm = TASCalculatorViewModel()
    TASFromAltimeterCalculatorView(vm: vm)
}

