//
//  PressureAltitudeCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

struct PressureAltitudeCalculatorView: View {
    @State var vm = PressureAltitudeCalculatorViewModel()
    
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
            altimeterSetting
            fieldElevation
        }
    }

    var computedResults: some View {
        VStack {
            pressureAltitude
        }
    }

    var altimeterSetting: some View {
        CustomTextFieldView(title: "Altimeter Setting", value: $vm.calculator.altimeterSetting, placeHolder: "Altimeter Setting (inHg)")
    }

    var fieldElevation: some View {
        CustomTextFieldView(title: "Field Elevation", value: $vm.calculator.fieldElevation, placeHolder: "Field Elevation (ft)")
    }

    var pressureAltitude: some View {
        CustomTextView(title: "Pressure Altitude", value: vm.calculator.pressureAltitude)
    }
}

#Preview {
//    @Previewable @State var vm = PressureAltitudeCalculatorViewModel()
    PressureAltitudeCalculatorView()
}
