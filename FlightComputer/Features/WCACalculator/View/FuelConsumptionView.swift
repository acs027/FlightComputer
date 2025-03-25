//
//  FuelConsumptionView.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import SwiftUI

struct FuelConsumptionView: View {
    @State var vm: WindCorrectionViewModel
    @FocusState.Binding var focused: WindCorrectionCalculatorView.WCACalculatorFocus?
    
    var body: some View {
        VStack {
            Text("Fuel Consumption for Flight Time")
                .bold()
                .font(.headline)
            flightTime
            fuelPerHour
            requiredFuel
        }
        .onChange(of: vm.flightTimeCalculator.flightTime) { oldValue, newValue in
            if newValue > 0 {
                vm.fuelConsumptionCalc.flightTime = newValue
            }
        }
    }
    
    var flightTime: some View {
//        CustomTextFieldView(title: "Flight Time", value: $vm.fuelConsumptionCalc.flightTime, placeHolder: "Flight Time")
        TimeTextFieldView(title: "Flight Time", value: $vm.fuelConsumptionCalc.flightTime, placeHolder: "Flight Time")
            .focused($focused, equals: .flightTime)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var fuelPerHour: some View {
        CustomTextFieldView(title: "Fuel per hour", value: $vm.fuelConsumptionCalc.fuelPerHour, placeHolder: "Fuel per hour")
            .focused($focused, equals: .fuelPerHour)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var requiredFuel: some View {
        CustomTextView(title: "Required Fuel", value: vm.fuelConsumptionCalc.requiredFuel)
    }
}

//#Preview {
//    @Previewable @State var vm = WindCorrectionViewModel()
//    FuelConsumptionView(vm: vm)
//}
