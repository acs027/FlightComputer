//
//  WindSideProLineAngleSlider.swift
//  FlightComputer
//
//  Created by ali cihan on 12.03.2025.
//

import SwiftUI

struct WindSideProLineAngleSlider: View {
    let isAngleInRange: (_ value: Double) -> Bool
    @Binding var lineAngle: Angle
    let title: String = "Angle:"
    
    var body: some View {
        angleSlider
    }
    var angleSlider: some View {
        VStack {
            Slider(value: $lineAngle.degrees, in: -50...50, step: 1)
            
            Stepper(value: $lineAngle.degrees, in: -50...50, step: 1) {
                HStack {
                    Text(title)
                    TextField("Enter a number", text: angleFormattedBinding)
                }
            }
        }
    }
    
    private var angleFormattedBinding: Binding<String> {
        Binding(
            get: { String(format: "%.0f°", lineAngle.degrees) },
            set: { newValue in
                if let value = Double(newValue), isAngleInRange(value) {
                    lineAngle.degrees = value
                }
            }
        )
    }
}

//#Preview {
//    WindSideProLineAngleSlider()
//}
