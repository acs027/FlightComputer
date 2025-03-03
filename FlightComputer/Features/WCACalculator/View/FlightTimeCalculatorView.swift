//
//  FlightTimeCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import SwiftUI

extension FlightTimeCalculatorView {
    enum Focus {
        case distanceField
        case groundSpeed
    }
}

struct FlightTimeCalculatorView: View {
    @State var vm: WindCorrectionViewModel
    @FocusState var focused: Focus?
    
    var body: some View {
        VStack {
            Text("Flight Time for Distance & Ground Speed")
                .bold()
                .font(.headline)
            distanceField
            groundSpeed
            flightTime
        }
        .onChange(of: vm.wCACalculator.groundSpeed ?? 0) { oldValue, newValue in
            if newValue > 0 {
                vm.flightTimeCalculator.groundSpeed = newValue
            }
        }
    }
    
    var distanceField: some View {
        CustomTextFieldView(title: "Distance", value: $vm.flightTimeCalculator.distance, placeHolder: "Distance")
            .focused($focused, equals: .distanceField)
    }
    
    var groundSpeed: some View {
        CustomTextFieldView(title: "Ground Speed", value: $vm.flightTimeCalculator.groundSpeed, placeHolder: "Ground Speed")
            .focused($focused, equals: .groundSpeed)
    }
    
    var flightTime: some View {
        CustomTextView(title: "Flight Time", value: vm.flightTimeCalculator.flightTime)
    }
}

#Preview {
    @Previewable @State var vm = WindCorrectionViewModel()
    FlightTimeCalculatorView(vm: vm)
}
