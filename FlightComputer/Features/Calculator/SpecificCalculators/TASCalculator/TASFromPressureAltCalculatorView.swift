//
//  TASFromPressureAltCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

import SwiftUI

struct TASFromPressureAltCalculatorView: View {
    @Bindable var vm: TASCalculatorViewModel
    @FocusState var focused: FocusField?
    
    var body: some View {
        VStack {
            userInputs
            computedResults
        }
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
            pressureAltitude
            outsideAirTemp
            indicatedAirSpeed
        }
    }
    
    var computedResults: some View {
        VStack {
            trueAirSpeed
        }
    }
    
    var pressureAltitude: some View {
        VStack {
            CustomTextFieldView(title: "Pressure Altitude", value: $vm.tasFromPressureAltCalculator.pressureAltitude, placeHolder: "Altitude (m)", unit: vm.tasFromPressureAltCalculator.pressureAltitudeUnit.symbol)
            Picker("Altitude Unit", selection: $vm.tasFromPressureAltCalculator.pressureAltitudeUnit) {
                ForEach(Distance.allCases, id: \.symbol) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        
            .focused($focused, equals: .pressureAltitude)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var outsideAirTemp: some View {
        VStack {
            CustomTextFieldView(title: "Outside Air Temperature", value: $vm.tasFromPressureAltCalculator.outsideAirTemp, placeHolder: "Temperature (°C)", unit: vm.tasFromPressureAltCalculator.outsideAirTempUnit.symbol)
            Picker("Outside Air Temperature", selection: $vm.tasFromPressureAltCalculator.outsideAirTempUnit) {
                ForEach(Temperature.allCases, id: \.symbol) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        
            .focused($focused, equals: .oat)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var indicatedAirSpeed: some View {
        CustomTextFieldView(title: "Indicated Air Speed", value: $vm.tasFromPressureAltCalculator.indicatedAirSpeed, placeHolder: "Indicated Air Speed (IAS) (knots)")
            .focused($focused, equals: .ias)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var trueAirSpeed: some View {
        CustomTextView(title: "True Air Speed", value: vm.tasFromPressureAltCalculator.trueAirSpeed)
    }
}

extension TASFromPressureAltCalculatorView {
    enum FocusField {
        case pressureAltitude, oat, ias
        
        func next() -> FocusField? {
            switch self {
            case .pressureAltitude:
                return .oat
            case .oat:
                return .ias
            case .ias:
                return nil
            }
        }
    }
}

#Preview {
    @Previewable @State var vm = TASCalculatorViewModel()
    TASFromPressureAltCalculatorView(vm: vm)
}

