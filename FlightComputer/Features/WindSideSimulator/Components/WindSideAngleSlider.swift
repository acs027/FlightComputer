//
//  WindSideAngleSlider.swift
//  FlightComputer
//
//  Created by ali cihan on 20.02.2025.
//

import SwiftUI

struct WindSideAngleSlider: View {
    let isAngleInRange: (_ value: Double) -> Bool
    @Binding var rotation: Angle
    let step: WCACalculationSteps
    var title: String {
        switch step {
        case .windDirection:
            "Wind Direction:"
        case .trueCourse:
            "True Course:"
        default:
            "Degree:"
        }
    }
    
    var body: some View {
        angleSlider
    }
    var angleSlider: some View {
        VStack {
            Slider(value: $rotation.degrees, in: 0...360, step: 1)
            
            Stepper(value: $rotation.degrees, in: 0...360, step: 1) {
                HStack {
                    Text(title)
                    TextField("Enter a number", text: angleFormattedBinding)
                }
            }
        }
    }
    
    private var angleFormattedBinding: Binding<String> {
        Binding(
            get: { String(format: "%.0f°", rotation.degrees) },
            set: { newValue in
                if let value = Double(newValue), isAngleInRange(value) {
                    rotation.degrees = value
                }
            }
        )
    }
}

#Preview {
    @Previewable @State var vm = WindSideViewModel()
    @Previewable @State var rotation: Angle = .degrees(0)
    @Previewable var step: WCACalculationSteps = .trueCourse
    WindSideAngleSlider(isAngleInRange: vm.isAngleInRange, rotation: $rotation, step: step)
}
