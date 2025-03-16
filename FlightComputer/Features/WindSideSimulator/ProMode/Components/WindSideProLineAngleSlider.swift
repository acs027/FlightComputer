//
//  WindSideProLineAngleSlider.swift
//  FlightComputer
//
//  Created by ali cihan on 12.03.2025.
//

import SwiftUI

struct WindSideProLineAngleSlider: View {
    @Binding var lineDegree: Double
    let title: String = "Angle:"
    
    var body: some View {
        angleSlider
    }
    var angleSlider: some View {
        VStack {
            Slider(value: $lineDegree, in: -50...50, step: 1)
            
            Stepper(value: $lineDegree, in: -50...50, step: 1) {
                HStack {
                    Text(title)
                    TextField("Enter a number", text: angleFormattedBinding)
                }
            }
        }
    }
    
    private var angleFormattedBinding: Binding<String> {
        Binding(
            get: { String(format: "%.0f°", lineDegree) },
            set: { newValue in
                if let value = Double(newValue), isLineAngleInRange(value: value) {
                    lineDegree = value
                }
            }
        )
    }
    
    func isLineAngleInRange(value: Double) -> Bool {
        let range: ClosedRange<Double> = -50...50
        return range.contains(value)
    }
}

//#Preview {
//    WindSideProLineAngleSlider()
//}
