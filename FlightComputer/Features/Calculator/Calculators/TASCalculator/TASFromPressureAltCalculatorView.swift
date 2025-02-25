//
//  TASFromPressureAltCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

import SwiftUI

struct TASFromPressureAltCalculatorView: View {
    @Bindable var vm: TASCalculatorViewModel
    
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
            indicatedAirSpeed
        }
    }
    
    var computedResults: some View {
        VStack {
            trueAirSpeed
        }
    }
    
    var pressureAltitude: some View {
        CustomTextFieldView(title: "Pressure Altitude", value: $vm.tasFromPressureAltCalculator.pressureAltitude, placeHolder: "Altitude (m)")
    }
    
    var outsideAirTemp: some View {
        CustomTextFieldView(title: "Outside Air Temperature", value: $vm.tasFromPressureAltCalculator.outsideAirTemp, placeHolder: "Temperature (°C)")
    }
    
    var indicatedAirSpeed: some View {
        CustomTextFieldView(title: "Indicated Air Speed", value: $vm.tasFromPressureAltCalculator.indicatedAirSpeed, placeHolder: "Indicated Air Speed (IAS) (knots)")
    }
    
    var trueAirSpeed: some View {
        CustomTextView(title: "True Air Speed", value: vm.tasFromPressureAltCalculator.trueAirSpeed)
    }
}

#Preview {
    @Previewable @State var vm = TASCalculatorViewModel()
    TASFromPressureAltCalculatorView(vm: vm)
}

