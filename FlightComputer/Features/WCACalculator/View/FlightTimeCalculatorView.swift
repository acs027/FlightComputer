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
        case notFocused
        
        mutating func next() {
            switch self {
            case .distanceField:
                self = .groundSpeed
            case .groundSpeed:
                self = .notFocused
            case .notFocused:
                return
            }
        }
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
        .onChange(of: vm.wCACalculator.groundSpeed) { oldValue, newValue in
            if newValue > 0 {
                vm.flightTimeCalculator.groundSpeed = newValue
            }
        }
    }
    
    var distanceField: some View {
        CustomTextFieldView(title: "Distance", value: $vm.flightTimeCalculator.distance, placeHolder: "Distance")
            .focused($focused, equals: .distanceField)
            .onSubmit {
                focused?.next()
            }
    }
    
    var groundSpeed: some View {
        CustomTextFieldView(title: "Ground Speed", value: $vm.flightTimeCalculator.groundSpeed, placeHolder: "Ground Speed")
            .focused($focused, equals: .groundSpeed)
            .onSubmit {
                focused?.next()
            }
    }
    
    var flightTime: some View {
        TimeTextView(title: "Flight Time", value: vm.flightTimeCalculator.flightTime)
    }
}

#Preview {
    @Previewable @State var vm = WindCorrectionViewModel()
    FlightTimeCalculatorView(vm: vm)
}
