//
//  CloudBaseCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI


struct CloudBaseCalculatorView: View {
    @State var vm = CloudBaseCalculatorViewModel()
    @FocusState var focused: FocusField?
    
    
    var body: some View {
        ScrollView {
                userInputs
                computedResults
        }
        .navigationTitle("Cloud Base")
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    focused = nil
                }
            }
        }
    }
    
    var userInputs: some View {
        VStack {
            ambientTemp
            ambientDewpoint
            stationAltitude
        }
    }
    
    var computedResults: some View {
        VStack {
            cloudBaseAltitude
        }
    }
    
    var ambientTemp: some View {
        VStack {
            CustomTextFieldView(title: "Ambient Temperature", value: $vm.cloudBaseCalculator.ambientTemp, placeHolder: "Temperature", unit: vm.cloudBaseCalculator.ambientTempUnit.symbol)
            Picker("Ambient Temperature Unit", selection: $vm.cloudBaseCalculator.ambientTempUnit) {
                ForEach(Temperature.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        .focused($focused, equals: .ambientTemp)
        .onSubmit {
            focused?.next()
        }
    }
    
    var ambientDewpoint: some View {
        VStack {
            CustomTextFieldView(title: "Dewpoint", value: $vm.cloudBaseCalculator.ambientDewpoint, placeHolder: "Dewpoint", unit: vm.cloudBaseCalculator.ambientDewpointUnit.symbol)
            Picker("Dewpoint Unit", selection: $vm.cloudBaseCalculator.ambientDewpointUnit) {
                ForEach(Temperature.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        .focused($focused, equals: .ambientDewpoint)
        .onSubmit {
            focused?.next()
        }
    }
    
    var stationAltitude: some View {
        VStack {
            CustomTextFieldView(title: "Station Altitude", value: $vm.cloudBaseCalculator.stationAltitude, placeHolder: "Station Altitude", unit: vm.cloudBaseCalculator.stationAltitudeUnit.symbol)
            Picker("Station Altitude Unit", selection: $vm.cloudBaseCalculator.stationAltitudeUnit) {
                ForEach(Distance.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        .focused($focused, equals: .stationAltitude)
        .onSubmit {
            focused?.next()
        }
    }
    
    var cloudBaseAltitude: some View {
        CustomTextView(title: "Cloud Base Altitude", value: vm.cloudBaseCalculator.cloudBaseAltitude, unit: vm.cloudBaseCalculator.stationAltitudeUnit.symbol)
    }
}

extension CloudBaseCalculatorView {
    enum FocusField {
        case ambientTemp, ambientDewpoint, stationAltitude, notFocused
        
        mutating func next() {
            switch self {
            case .ambientTemp:
                self = .ambientDewpoint
            case .ambientDewpoint:
                self = .stationAltitude
            case .stationAltitude:
                self = .notFocused
            default:
                self = .ambientTemp
            }
        }
    }
}

#Preview {
//    @Previewable @State var vm = CloudBaseCalculatorViewModel()
    CloudBaseCalculatorView()
}
