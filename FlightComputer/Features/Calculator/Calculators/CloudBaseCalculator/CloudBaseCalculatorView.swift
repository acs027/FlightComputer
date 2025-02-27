//
//  CloudBaseCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

struct CloudBaseCalculatorView: View {
    @State var vm = CloudBaseCalculatorViewModel()
    
    var body: some View {
        ScrollView {
                userInputs
                computedResults
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
            CustomTextFieldView(title: "Ambient Temperature", value: $vm.cloudBaseCalculator.ambientTemp, placeHolder: "Temperature (°C)", unit: vm.cloudBaseCalculator.ambientTempUnit.symbol)
            Picker("Ambient Temperature Unit", selection: $vm.cloudBaseCalculator.ambientTempUnit) {
                ForEach(Temperature.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
    }
    
    var ambientDewpoint: some View {
        VStack {
            CustomTextFieldView(title: "Dewpoint", value: $vm.cloudBaseCalculator.ambientDewpoint, placeHolder: "Dewpoint (°C)", unit: vm.cloudBaseCalculator.ambientDewpointUnit.symbol)
            Picker("Dewpoint Unit", selection: $vm.cloudBaseCalculator.ambientDewpointUnit) {
                ForEach(Temperature.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
    }
    
    var stationAltitude: some View {
        VStack {
            CustomTextFieldView(title: "Station Altitude", value: $vm.cloudBaseCalculator.stationAltitude, placeHolder: "Altitude (m)", unit: vm.cloudBaseCalculator.stationAltitudeUnit.symbol)
            Picker("Station Altitude Unit", selection: $vm.cloudBaseCalculator.stationAltitudeUnit) {
                ForEach(Distance.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
    }
    
    var cloudBaseAltitude: some View {
        CustomTextView(title: "Cloud Base Altitude", value: vm.cloudBaseCalculator.cloudBaseAltitude, unit: vm.cloudBaseCalculator.stationAltitudeUnit.symbol)
    }
}

#Preview {
//    @Previewable @State var vm = CloudBaseCalculatorViewModel()
    CloudBaseCalculatorView()
}
