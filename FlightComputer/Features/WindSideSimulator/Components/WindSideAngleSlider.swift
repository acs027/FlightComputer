//
//  WindSideAngleSlider.swift
//  FlightComputer
//
//  Created by ali cihan on 20.02.2025.
//

import SwiftUI

struct WindSideAngleSlider: View {
    @Binding var rotation: Double
    var title: String = "Degree: "
    
    var body: some View {
        angleSlider
    }
    var angleSlider: some View {
        VStack {
            Slider(value: $rotation, in: 0...360, step: 1)
            
            Stepper(value: $rotation, in: 0...360, step: 1) {
                HStack {
                    Text(title)
                    TextField("Enter a number", text: angleFormattedBinding)
                }
            }
        }
    }
    
    private var angleFormattedBinding: Binding<String> {
        Binding(
            get: { String(format: "%.0f°", rotation) },
            set: { newValue in
                if let value = Double(newValue), isAngleInRange(value: value) {
                    rotation = value
                }
            }
        )
    }
    
    func isAngleInRange(value: Double) -> Bool {
        let range: ClosedRange<Double> = 0...360
        return range.contains(value)
    }
}

#Preview {
    @Previewable @State var rotation: Double = 0
    @Previewable var step: WCACalculationSteps = .trueCourse
    WindSideAngleSlider(rotation: $rotation)
}
