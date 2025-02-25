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
        CustomTextFieldView(title: "Air Temperature", value: $vm.calculator.airTemp, placeHolder: "Air Temperature (°C)")
    }

    var dewpoint: some View {
        CustomTextFieldView(title: "Dewpoint", value: $vm.calculator.dewpoint, placeHolder: "Dewpoint (°C)")
    }

    var relativeHumidity: some View {
        CustomTextView(title: "Relative Humidity", value: vm.calculator.relativeHumidity)
    }
}

#Preview {
//    @Previewable @State var vm = RelativeHumidityCalculatorViewModel()
    RelativeHumidityCalculatorView()
}
