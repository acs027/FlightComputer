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
        VStack {
            CustomTextFieldView(title: "Air Temperature", value: $vm.calculator.airTemp, placeHolder: "Air Temperature", unit: vm.calculator.airTempUnit.symbol)
            Picker("Air Temperature Unit", selection: $vm.calculator.airTempUnit) {
                ForEach(Temperature.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
    }

    var relativeHumidity: some View {
        CustomTextFieldView(title: "Relative Humidity", value: $vm.calculator.relativeHumidity, placeHolder: "Humidity (%)")
    }

    var dewpoint: some View {
        CustomTextView(title: "Dewpoint", value: vm.calculator.dewpoint ?? 0, unit: vm.calculator.airTempUnit.symbol)
    }
}

extension DewpointCalculatorView {
    enum FocusField {
        case airTemp, relativeHumidity, notFocused
        
        mutating func next() {
            switch self {
            case .airTemp:
                self = .relativeHumidity
            case .relativeHumidity:
                self = .notFocused
            default:
                self = .airTemp
            }
        }
    }
}

#Preview {
//    @Previewable @State var vm = DewpointCalculatorViewModel()
    DewpointCalculatorView()
}
