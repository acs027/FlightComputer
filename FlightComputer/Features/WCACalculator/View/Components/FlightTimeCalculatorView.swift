//
//  FlightTimeCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import SwiftUI

struct FlightTimeCalculatorView: View {
    @State var vm: WindCorrectionViewModel
    @FocusState.Binding var focused: WindCorrectionCalculatorView.WCACalculatorFocus?
    typealias FocusField = WindCorrectionCalculatorView.WCACalculatorFocus
    
    var body: some View {
        VStack {
            Text("Flight Time for Distance & Ground Speed")
                .bold()
                .font(.headline)
            distanceField
            groundSpeed
            flightTime
        }
        .onChange(of: vm.wCACalculator.groundSpeed) { oldValue, newValue in
            if newValue > 0 {
                vm.flightTimeCalculator.groundSpeed = newValue
            }
        }
    }
    
    var distanceField: some View {
        CustomTextFieldView<FocusField>(title: "Distance", value: $vm.flightTimeCalculator.distance, focus: $focused, field: .distanceField, placeHolder: "Distance")
            .focused($focused, equals: .distanceField)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var groundSpeed: some View {
        CustomTextFieldView<FocusField>(title: "Ground Speed", value: $vm.flightTimeCalculator.groundSpeed, focus: $focused, field: .groundSpeed, placeHolder: "Ground Speed")
            .focused($focused, equals: .groundSpeed)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var flightTime: some View {
        TimeTextView(title: "Flight Time", value: vm.flightTimeCalculator.flightTime)
    }
}

//#Preview {
//    @Previewable @State var vm = WindCorrectionViewModel()
//    FlightTimeCalculatorView(vm: vm)
//}
