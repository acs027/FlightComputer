//
//  WindSideWindSpeedSlider.swift
//  FlightComputer
//
//  Created by ali cihan on 20.02.2025.
//

import SwiftUI

struct WindSideWindSpeedSlider: View {
    @Binding var markOffset: CGFloat
    let unitHeight: Double
    let isHighSpeed: Bool
    
    var windSpeedValue: Double {
        getWindSpeedValue()
    }
    
    var body: some View {
        markSlider
    }
    //MARK: Sliders
    var markSlider: some View {
        VStack{
            Slider(value: $markOffset, in: windMarkRange(), step: unitHeight)
                .rotationEffect(.degrees(180))
            Stepper {
                HStack {
                    Text("Wind speed: ")
                    TextField("Wind Speed", text: markFormattedBinding)
                }
            } onIncrement: {
                markOffset = windMarkStepperIncrement(value: markOffset)
            } onDecrement: {
                markOffset = windMarkStepperDecrement(value: markOffset)
            }
        }
    }
    
    private var markFormattedBinding: Binding<String> {
        Binding(
            get: { String(format: "%.2f", abs(windSpeedValue)) },
            set: { newValue in
                if let value = Double(newValue),
                   isMarkInRange(value: value)
                {
                    markOffset = calculateWindMarkOffset(value: value)
                }
            }
        )
    }
    
    func isMarkInRange(value: Double) -> Bool {
        let range = windMarkRange()
        let convertedValue = -value * unitHeight
        return range.contains(convertedValue)
    }
    
    
    func windMarkRange() -> ClosedRange<CGFloat> {
        let highestPoint: CGFloat = .zero
        let lowestPoint: CGFloat = -unitHeight * 50
        return lowestPoint...highestPoint
    }
    
    func windMarkStepperIncrement(value: Double) -> Double {
        if value > -unitHeight * 49 {
            return value - unitHeight
        }
        return -unitHeight * 50
    }
    
    func windMarkStepperDecrement(value: Double) -> Double {
        if value < -unitHeight {
            return value + unitHeight
        }
        return 0
    }
    
    
    func calculateWindMarkOffset(value: Double) -> Double {
        var value = value
        if isHighSpeed {
            value /= 5
        }
        let markOffset = -value * unitHeight
        return markOffset
    }
    
    func getWindSpeedValue() -> Double {
        var value = markOffset / unitHeight
        if isHighSpeed {
            value *= 5
        }
        return value
    }
}

#Preview {
    @Previewable @State var markOffset: CGFloat = .zero
    @Previewable var unitHeight: Double = 20
    @Previewable var markValue: CGFloat = .zero
    WindSideWindSpeedSlider(markOffset: $markOffset, unitHeight: unitHeight, isHighSpeed: false)
    
}
