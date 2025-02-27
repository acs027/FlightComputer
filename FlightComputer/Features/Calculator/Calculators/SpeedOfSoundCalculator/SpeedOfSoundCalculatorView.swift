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
        }
    }
    
    var computedResults: some View {
        VStack {
//            calculatedSpeed
            speedOfSound
        }
    }
    
    var altitude: some View {
        VStack {
            CustomTextFieldView(title: "Altitude", value: $vm.speedOfSoundCalculator.altitude, placeHolder: "Altitude (ft or m)")
            Picker("Altimeter Unit", selection: $vm.speedOfSoundCalculator.altitudeUnit) {
                ForEach(Distance.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
    }
    
    var standardTemperature: some View {
        VStack {
            CustomTextFieldView(title: "Standard Temperature", value: $vm.speedOfSoundCalculator.standardTemperature, placeHolder: "Temperature (°C)", unit: vm.speedOfSoundCalculator.standardTemperatureUnit.symbol)
            Picker("Standart Temperature Unit", selection: $vm.speedOfSoundCalculator.standardTemperatureUnit) {
                ForEach(Temperature.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
    }
    
    var speedOfSound: some View {
        VStack {
            CustomTextView(title: "Speed of Sound", value: vm.speedOfSoundCalculator.speedOfSoundAtAltitude, unit: vm.speedOfSoundCalculator.standardTemperatureUnit.symbol)
            Picker("Speed of Sound", selection: $vm.speedOfSoundCalculator.speedUnit) {
                ForEach(Speed.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
    }
}

#Preview {
//    @Previewable @State var vm = SpeedOfSoundCalculatorViewModel()
    SpeedOfSoundCalculatorView()
}

