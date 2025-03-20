//
//  WindSideTASSlider.swift
//  FlightComputer
//
//  Created by ali cihan on 20.02.2025.
//

import SwiftUI

struct WindSideTASSlider: View {
    @Binding var verticalOffset: CGFloat
    var unitHeight: Double
    var title: String = "True Air Speed"
    let isHighSpeed: Bool
    
    var speedValue: Double {
        getSpeedValue()
    }
    
    var body: some View {
        verticalSlider
    }
    
    var verticalSlider: some View {
        VStack{
            Slider(value: $verticalOffset, in: verticalRange(), step: unitHeight)
                .rotationEffect(.degrees(180))
            Stepper {
                HStack {
                    Text("\(title): ")
                    TextField("True Air Speed", text: verticalFormattedBinding)
                }
            } onIncrement: {
                verticalOffset = verticalStepperIncrement(value: verticalOffset)
            } onDecrement: {
                verticalOffset = verticalStepperDecrement(value: verticalOffset)
            }
        }
    }
    
    private var verticalFormattedBinding: Binding<String> {
        Binding(
            get: { String(format: "%.0f", (speedValue)) },
            set: { newValue in
                if let value = Double(newValue),
                   isVerticalOffsetInRange(value: value){
                    verticalOffset = calculateVerticalOffset(value: value)
                }
            }
        )
    }
    
    func isVerticalOffsetInRange(value: Double) -> Bool {
        let range = verticalRange()
        let convertedValue = (170 - value) * unitHeight
        return range.contains(convertedValue)
    }
    
    func verticalStepperIncrement(value: Double) -> Double {
        if value > -unitHeight * 89 {
            return value - unitHeight
        }
        return -unitHeight * 90
    }
    
    func verticalStepperDecrement(value: Double) -> Double {
        if value < unitHeight * 129 {
            return value + unitHeight
        }
        return unitHeight * 130
    }
    
    func verticalRange() -> ClosedRange<CGFloat> {
        let highestPoint = unitHeight * 130
        let lowestPoint = -unitHeight * 90
        return lowestPoint...highestPoint
    }
    
    func calculateVerticalOffset(value: Double) -> Double {
        if value < 1 {
            return 0
        }
        var value = value
        if isHighSpeed {
            value /= 5
        }
        let result = (170 - value) * unitHeight
        return result
    }
    
    func getSpeedValue() -> Double {
        let value = 170 - verticalOffset / unitHeight
        return isHighSpeed ? 5 * value : value
    }
}

#Preview {
    @Previewable @State var verticalOffset: CGFloat = .zero
    @Previewable var unitHeight: Double = 20
    WindSideTASSlider(verticalOffset: $verticalOffset, unitHeight: unitHeight, isHighSpeed: false)
}
