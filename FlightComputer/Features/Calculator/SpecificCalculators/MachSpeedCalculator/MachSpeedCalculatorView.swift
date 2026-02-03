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
        .navigationTitle("Mach Speed Calculator")
//        .toolbar {
//            ToolbarItemGroup(placement: .keyboard) {
//                Spacer()
//                Button("Done") {
//                    focused = nil
//                }
//            }
//        }
    }

    var altitude: some View {
        VStack {
           
            CustomTextFieldView<FocusField>(title: "Altitude", value: $vm.calculator.altitude, focus: $focused, field: .altitude, placeHolder: "Altitude", unit: vm.calculator.altitudeUnit.symbol)
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
            focused = focused?.next()
        }
    }

    var standardTemperature: some View {
        VStack {
            CustomTextFieldView<FocusField>(title: "Standard Temperature", value: $vm.calculator.standardTemperature, focus: $focused, field: .standartTemp, placeHolder: "Standard Temperature", unit: vm.calculator.standardTemperatureUnit.symbol)
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
            focused = focused?.next()
        }
    }

    var machSpeed: some View {
        VStack {
            CustomTextView(title: "Mach Speed", value: vm.calculator.speedOfSoundAtAltitude, unit: vm.calculator.machSpeedUnit.symbol)
        }
    }
    
    var speed: some View {
        VStack {
            CustomTextFieldView<FocusField>(title: "Speed", value: $vm.calculator.speed, focus: $focused, field: .speed, placeHolder: "Speed ", unit: vm.calculator.machSpeedUnit.symbol)
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
            focused = focused?.next()
        }
    }


    var machNumber: some View {
        CustomTextView(title: "Mach Number", value: vm.calculator.machNumber)
    }
}

extension MachSpeedCalculatorView {
    enum FocusField {
        case altitude, standartTemp, speed

        func next() -> FocusField? {
            switch self {
            case .altitude:
                return .standartTemp
            case .standartTemp:
                return .speed
            case .speed:
                return nil
            }
        }
    }
}

#Preview {
//    @Previewable @State var vm = MachSpeedCalculatorViewModel()
    MachSpeedCalculatorView()
}
