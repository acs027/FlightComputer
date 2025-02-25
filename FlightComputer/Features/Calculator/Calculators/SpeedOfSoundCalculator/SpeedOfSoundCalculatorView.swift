//
//  SpeedOfSoundCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

struct SpeedOfSoundCalculatorView: View {
    @State var vm = SpeedOfSoundCalculatorViewModel()
    
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
            selectedUnit
        }
    }
    
    var computedResults: some View {
        VStack {
            calculatedSpeed
            machNumber
        }
    }
    
    var altitude: some View {
        CustomTextFieldView(title: "Altitude", value: $vm.speedOfSoundCalculator.altitude, placeHolder: "Altitude (ft or m)")
    }
    
    var standardTemperature: some View {
        CustomTextFieldView(title: "Standard Temperature", value: $vm.speedOfSoundCalculator.standardTemperature, placeHolder: "Temperature (°C)")
    }
    
    var selectedUnit: some View {
        Picker("Speed Unit", selection: $vm.speedOfSoundCalculator.selectedUnit) {
            Text("Knots").tag(SpeedOfSoundCalculator.SpeedUnit.knots)
            Text("MPH").tag(SpeedOfSoundCalculator.SpeedUnit.mph)
            Text("KM/H").tag(SpeedOfSoundCalculator.SpeedUnit.kmh)
            Text("M/S").tag(SpeedOfSoundCalculator.SpeedUnit.metersPerSecond)
        }
        .pickerStyle(SegmentedPickerStyle())
    }
    
    var calculatedSpeed: some View {
        CustomTextView(title: "Speed of Sound", value: vm.speedOfSoundCalculator.calculatedSpeed)
    }
    
    var machNumber: some View {
        CustomTextView(title: "Mach Number", value: vm.speedOfSoundCalculator.machNumber)
    }
}

#Preview {
//    @Previewable @State var vm = SpeedOfSoundCalculatorViewModel()
    SpeedOfSoundCalculatorView()
}

