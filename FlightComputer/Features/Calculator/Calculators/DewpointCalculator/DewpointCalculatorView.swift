//
//  DewpointCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import SwiftUI

import SwiftUI

struct DewpointCalculatorView: View {
    @State var vm = DewpointCalculatorViewModel()

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
            relativeHumidity
        }
    }

    var computedResults: some View {
        VStack {
            dewpoint
        }
    }

    var airTemp: some View {
        CustomTextFieldView(title: "Air Temperature", value: $vm.calculator.airTemp, placeHolder: "Temperature (°C)")
    }

    var relativeHumidity: some View {
        CustomTextFieldView(title: "Relative Humidity", value: $vm.calculator.relativeHumidity, placeHolder: "Humidity (%)")
    }

    var dewpoint: some View {
        CustomTextView(title: "Dewpoint", value: vm.calculator.dewpoint ?? 0)
    }
}

#Preview {
//    @Previewable @State var vm = DewpointCalculatorViewModel()
    DewpointCalculatorView()
}
