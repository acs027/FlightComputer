//
//  DensityAltitudeCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

import SwiftUI

struct DensityAltitudeCalculatorView: View {
    @State var vm = DensityAltitudeCalculatorViewModel()

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
            pressureAltitude
            oat
        }
    }

    var computedResults: some View {
        VStack {
            isaTemp
            densityAltitude
        }
    }

    var pressureAltitude: some View {
        CustomTextFieldView(title: "Pressure Altitude", value: $vm.calculator.pressureAltitude, placeHolder: "Altitude (ft)")
    }

    var oat: some View {
        CustomTextFieldView(title: "Outside Air Temperature", value: $vm.calculator.oat, placeHolder: "Temperature (°C)")
    }

    var isaTemp: some View {
        CustomTextView(title: "ISA Temperature", value: vm.calculator.isaTemp)
    }

    var densityAltitude: some View {
        CustomTextView(title: "Density Altitude", value: vm.calculator.densityAltitude)
    }
}

#Preview {
//    @Previewable @State var vm = DensityAltitudeCalculatorViewModel()
    DensityAltitudeCalculatorView()
}
