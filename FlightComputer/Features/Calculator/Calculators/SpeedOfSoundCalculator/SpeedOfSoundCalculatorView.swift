//
//  SpeedOfSoundCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

struct SpeedOfSoundCalculatorView: View {
    @State var vm = SpeedOfSoundCalculatorViewModel()
    @FocusState var focused: FocusField?
    
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
            CustomTextFieldView(title: "Altitude", value: $vm.speedOfSoundCalculator.altitude, placeHolder: "Altitude")
            Picker("Altimeter Unit", selection: $vm.speedOfSoundCalculator.altitudeUnit) {
                ForEach(Distance.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        .focused($focused, equals: .altitude)
        .onSubmit {
            focused?.next()
        }
    }
    
    var standardTemperature: some View {
        VStack {
            CustomTextFieldView(title: "Standard Temperature", value: $vm.speedOfSoundCalculator.standardTemperature, placeHolder: "Temperature", unit: vm.speedOfSoundCalculator.standardTemperatureUnit.symbol)
            Picker("Standart Temperature Unit", selection: $vm.speedOfSoundCalculator.standardTemperatureUnit) {
                ForEach(Temperature.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        .focused($focused, equals: .standartTemp)
        .onSubmit {
            focused?.next()
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

extension SpeedOfSoundCalculatorView {
    enum FocusField {
        case altitude, standartTemp, notFocused
        
        mutating func next() {
            switch self {
            case .altitude:
                self = .standartTemp
            case .standartTemp:
                self = .notFocused
            default:
                self = .altitude
            }
        }
    }
}

#Preview {
//    @Previewable @State var vm = SpeedOfSoundCalculatorViewModel()
    SpeedOfSoundCalculatorView()
}

