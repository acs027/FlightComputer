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
        .navigationTitle("Speed of sound")
//        .toolbar {
//            ToolbarItemGroup(placement: .keyboard) {
//                Spacer()
//                Button("Done") {
//                    focused = nil
//                }
//            }
//        }
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
            CustomTextFieldView<FocusField>(title: "Altitude", value: $vm.speedOfSoundCalculator.altitude, focus: $focused, field: .altitude, placeHolder: "Altitude")
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
            focused = focused?.next()
        }
    }
    
    var standardTemperature: some View {
        VStack {
            CustomTextFieldView<FocusField>(title: "Standard Temperature", value: $vm.speedOfSoundCalculator.standardTemperature, focus: $focused, field: .standartTemp, placeHolder: "Temperature", unit: vm.speedOfSoundCalculator.standardTemperatureUnit.symbol)
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
            focused = focused?.next()
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
        case altitude, standartTemp
        
        func next() ->FocusField? {
            switch self {
            case .altitude:
                return .standartTemp
            case .standartTemp:
                return nil
            }
        }
    }
}

#Preview {
//    @Previewable @State var vm = SpeedOfSoundCalculatorViewModel()
    SpeedOfSoundCalculatorView()
}

