//
//  WindComponentCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

struct WindComponentCalculatorView: View {
    @State var vm = WindComponentCalculatorViewModel()
    @FocusState var focused: FocusField?
    
    var body: some View {
        ScrollView {
            VStack {
                userInputs
                computedResults
            }
        }
        .navigationTitle("Wind Component")
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
            windSpeed
            windDirection
            runwayHeading
        }
    }
    
    var computedResults: some View {
        VStack {
            headWind
            crossWind
        }
    }
    
    var windSpeed: some View {
        CustomTextFieldView(title: "Wind Speed", value: $vm.windComponentCalculator.windSpeed, placeHolder: "Wind Speed (knots)")
            .focused($focused, equals: .windSpeed)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var windDirection: some View {
        CustomTextFieldView(title: "Wind Direction", value: $vm.windComponentCalculator.windDirection, placeHolder: "Wind Direction (° from North)")
            .focused($focused, equals: .windDirection)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var runwayHeading: some View {
        CustomTextFieldView(title: "Runway Heading", value: $vm.windComponentCalculator.runwayHeading, placeHolder: "Runway Heading (°)")
            .focused($focused, equals: .runwayHeading)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var headWind: some View {
        CustomTextView(title: (vm.windComponentCalculator.headWind < 0 ? "Tail Wind" : "Head Wind"), value: abs(vm.windComponentCalculator.headWind))
    }
    
    var crossWind: some View {
        CustomTextView(title: "Cross Wind", value: vm.windComponentCalculator.crossWind)
    }
}

extension WindComponentCalculatorView {
    enum FocusField {
        case windSpeed, windDirection, runwayHeading
        
        func next() -> FocusField? {
            switch self {
            case .windSpeed:
                return .windDirection
            case .windDirection:
                return .runwayHeading
            case .runwayHeading:
                return nil
            }
        }
    }
}

#Preview {
//    @Previewable @State var vm = WindComponentCalculatorViewModel()
    WindComponentCalculatorView()
}

