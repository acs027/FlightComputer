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
    @FocusState var focused: FocusField?
    
    var body: some View {
        ScrollView {
            VStack {
                altitude
                standardTemperature
                machSpeed
                speed
                machNumber
            }
        }
    }

    var altitude: some View {
        VStack {
           
            CustomTextFieldView(title: "Altitude", value: $vm.calculator.altitude, placeHolder: "Altitude", unit: vm.calculator.altitudeUnit.symbol)
            Picker("Altitude Unit", selection: $vm.calculator.altitudeUnit) {
                ForEach(Distance.allCases, id: \.symbol) {
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
            CustomTextFieldView(title: "Standard Temperature", value: $vm.calculator.standardTemperature, placeHolder: "Standard Temperature", unit: vm.calculator.standardTemperatureUnit.symbol)
            Picker("Standart Temperature", selection: $vm.calculator.standardTemperatureUnit) {
                ForEach(Temperature.allCases, id: \.symbol) {
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

    var machSpeed: some View {
        VStack {
            CustomTextView(title: "Mach Speed", value: vm.calculator.speedOfSoundAtAltitude, unit: vm.calculator.machSpeedUnit.symbol)
//            Picker("Mach Speed Unit", selection: $vm.calculator.machSpeedUnit) {
//                ForEach(Speed.allCases, id: \.self) {
//                    unit in
//                    Text(unit.symbol).tag(unit)
//                }
//            }
//            .pickerStyle(.segmented)
//            .padding(.horizontal)
        }
    }
    
    var speed: some View {
        VStack {
            CustomTextFieldView(title: "Speed", value: $vm.calculator.speed, placeHolder: "Speed ", unit: vm.calculator.machSpeedUnit.symbol)
            Picker("Mach Speed Unit", selection: $vm.calculator.machSpeedUnit) {
                ForEach(Speed.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        .focused($focused, equals: .speed)
        .onSubmit {
            focused?.next()
        }
    }


    var machNumber: some View {
        CustomTextView(title: "Mach Number", value: vm.calculator.machNumber)
    }
}

extension MachSpeedCalculatorView {
    enum FocusField {
        case altitude, standartTemp, speed, notFocused

        mutating func next() {
            switch self {
            case .altitude:
                self = .standartTemp
            case .standartTemp:
                self = .speed
            case .speed:
                self = .notFocused
            default:
                self = .altitude
            }
        }
    }
}

#Preview {
//    @Previewable @State var vm = MachSpeedCalculatorViewModel()
    MachSpeedCalculatorView()
}
