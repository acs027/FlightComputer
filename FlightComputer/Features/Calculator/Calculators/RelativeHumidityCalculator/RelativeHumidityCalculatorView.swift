//
//  RelativeHumidityCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import SwiftUI

struct RelativeHumidityCalculatorView: View {
    @State var vm = RelativeHumidityCalculatorViewModel()
    
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
            airTemp
            dewpoint
        }
    }

    var computedResults: some View {
        VStack {
            relativeHumidity
        }
    }

    var airTemp: some View {
        VStack {
            CustomTextFieldView(title: "Air Temperature", value: $vm.calculator.airTemp, placeHolder: "Air Temperature (°C)", unit: vm.calculator.tempUnit.symbol)
            Picker("Air Temperature Unit", selection: $vm.calculator.tempUnit) {
                ForEach(Temperature.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
    }

    var dewpoint: some View {
        CustomTextFieldView(title: "Dewpoint", value: $vm.calculator.dewpoint, placeHolder: "Dewpoint (°C)", unit: vm.calculator.tempUnit.symbol)
    }

    var relativeHumidity: some View {
        CustomTextView(title: "Relative Humidity", value: vm.calculator.relativeHumidity)
    }
}

#Preview {
//    @Previewable @State var vm = RelativeHumidityCalculatorViewModel()
    RelativeHumidityCalculatorView()
}
