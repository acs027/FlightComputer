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
    var isLimited: Bool = false
    var previousValue: Double = 0
    var trueAirSpeed: Double = 0
    
    var body: some View {
        angleSlider
    }
    var angleSlider: some View {
        VStack {
            Slider(value: $rotation, in: angleRange(), step: 1)
            
            Stepper(value: $rotation, in: angleRange(), step: 1) {
                HStack {
                    Text(title)
                    TextField("Enter a number", text: angleFormattedBinding)
                }
            }
        }
    }
    
    private var angleFormattedBinding: Binding<String> {
        Binding(
            get: { String(format: "%.0f°", (rotation + 360).truncatingRemainder(dividingBy: 360)) },
            set: { newValue in
                if let value = Double(newValue), isAngleInRange(value: value) {
                    rotation = (value + 360).truncatingRemainder(dividingBy: 360)
                }
            }
        )
    }
    
    func angleRange() -> ClosedRange<Double> {
        var range: ClosedRange<Double> = 0...360
        if isLimited {
            var rangeValue: Double = 0
            if trueAirSpeed > 250 {
                rangeValue = atan( 50 / (trueAirSpeed / 5) ) * 180 / .pi
            } else {
                rangeValue = atan( 50 / (trueAirSpeed) ) * 180 / .pi
            }
            let lowEnd = (previousValue - rangeValue)
            let highEnd = (previousValue + rangeValue)
            range = lowEnd...highEnd
        }
        return range
    }
    
    func isAngleInRange(value: Double) -> Bool {
        let range = angleRange()
        return range.contains(value)
    }
}

#Preview {
    @Previewable @State var rotation: Double = 0
    @Previewable var step: WCACalculationSteps = .trueCourse
    WindSideAngleSlider(rotation: $rotation)
}
