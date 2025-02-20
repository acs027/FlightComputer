//
//  WindSideAngleSlider.swift
//  FlightComputer
//
//  Created by ali cihan on 20.02.2025.
//

import SwiftUI

struct WindSideAngleSlider: View {
    let vm: WindSideViewModel
    @Binding var rotation: Angle
    let step: WCACalculationSteps
    
    var body: some View {
        angleSlider
    }
    var angleSlider: some View {
        VStack {
            Slider(value: $rotation.degrees, in: 0...360, step: 1)
            
            Stepper(value: $rotation.degrees, in: 0...360, step: 1) {
                HStack {
                    Text(step == .windDirection ? "Wind Direction:" : "True Course:")
                    TextField("Enter a number", text: angleFormattedBinding)
                }
            }
        }
    }
    
    private var angleFormattedBinding: Binding<String> {
        Binding(
            get: { String(format: "%.0f°", rotation.degrees) },
            set: { newValue in
                if let value = Double(newValue), vm.isAngleInRange(value: value) {
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
    WindSideAngleSlider(vm: vm, rotation: $rotation, step: step)
}
