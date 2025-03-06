//
//  RelativeHumidityCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import SwiftUI

struct RelativeHumidityCalculatorView: View {
    @State var vm = RelativeHumidityCalculatorViewModel()
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
            CustomTextFieldView(title: "Air Temperature", value: $vm.calculator.airTemp, placeHolder: "Air Temperature", unit: vm.calculator.tempUnit.symbol)
            Picker("Air Temperature Unit", selection: $vm.calculator.tempUnit) {
                ForEach(Temperature.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        .focused($focused, equals: .airTemp)
        .onSubmit {
            focused?.next()
        }
    }

    var dewpoint: some View {
        CustomTextFieldView(title: "Dewpoint", value: $vm.calculator.dewpoint, placeHolder: "Dewpoint", unit: vm.calculator.tempUnit.symbol)
            .focused($focused, equals: .dewpoint)
            .onSubmit {
                focused?.next()
            }
    }

    var relativeHumidity: some View {
        CustomTextView(title: "Relative Humidity", value: vm.calculator.relativeHumidity)
    }
}

extension RelativeHumidityCalculatorView {
    enum FocusField {
        case airTemp, dewpoint, notFocused
        
        mutating func next() {
            switch self {
            case .airTemp:
                self = .dewpoint
            case .dewpoint:
                self = .notFocused
            default:
                self = .airTemp
            }
        }
    }
}

#Preview {
//    @Previewable @State var vm = RelativeHumidityCalculatorViewModel()
    RelativeHumidityCalculatorView()
}
