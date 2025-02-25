//
//  MachSpeedCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

import SwiftUI

struct MachSpeedCalculatorView: View {
    @State var vm = MachSpeedCalculatorViewModel()
    
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
            altitude
            standardTemperature
            selectedSpeedUnit
        }
    }

    var computedResults: some View {
        VStack {
            machSpeed
            calculatedSpeed
            machNumber
        }
    }

    var altitude: some View {
        CustomTextFieldView(title: "Altitude", value: $vm.calculator.altitude, placeHolder: "Altitude (ft or m)")
    }

    var standardTemperature: some View {
        CustomTextFieldView(title: "Standard Temperature", value: $vm.calculator.standardTemperature, placeHolder: "Standard Temp (°C)")
    }

    var selectedSpeedUnit: some View {
        Picker("Speed Unit", selection: $vm.calculator.selectedSpeedUnit) {
            Text("Knots").tag(MachSpeedCalculator.SpeedUnit.knots)
            Text("MPH").tag(MachSpeedCalculator.SpeedUnit.mph)
            Text("KM/H").tag(MachSpeedCalculator.SpeedUnit.kmh)
            Text("M/S").tag(MachSpeedCalculator.SpeedUnit.metersPerSecond)
        }
        .pickerStyle(SegmentedPickerStyle())
    }

    var machSpeed: some View {
        CustomTextView(title: "Mach Speed", value: vm.calculator.machSpeed)
    }

    var calculatedSpeed: some View {
        CustomTextView(title: "Speed", value: vm.calculator.calculatedSpeed)
    }

    var machNumber: some View {
        CustomTextView(title: "Mach Number", value: vm.calculator.machNumber)
    }
}

#Preview {
//    @Previewable @State var vm = MachSpeedCalculatorViewModel()
    MachSpeedCalculatorView()
}
