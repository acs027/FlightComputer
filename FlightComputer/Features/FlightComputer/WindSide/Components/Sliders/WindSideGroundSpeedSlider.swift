//
//  WindSideGroundSpeedSlider.swift
//  FlightComputer
//
//  Created by ali cihan on 17.03.2025.
//

import SwiftUI

struct WindSideGroundSpeedSlider: View {
    @State var groundSpeedValue: CGFloat = 0
    @Binding var markOffset: CGSize
    let verticalOffset: CGFloat
    let unitHeight: Double
    let isHighSpeed: Bool
    var drift: Double
    var groundSpeed: (Double) -> Void
        
    var body: some View {
        markSlider
            .onChange(of: groundSpeedValue) { oldValue, newValue in
                groundSpeed(newValue * (isHighSpeed ? 5 : 1))
                markOffsetCalculator()
            }
            .onAppear {
                if groundSpeedValue < 1 {
                    groundSpeedValue = abs(170 - verticalOffset / unitHeight)
                }
            }
    }
    
    //MARK: Sliders
    var markSlider: some View {
        VStack{
            Slider(value: $groundSpeedValue, in: windMarkRange(), step: step())
                .rotationEffect(.degrees(180))
            Stepper {
                HStack {
                    Text("Ground speed: ")
                    TextField("Ground speed", text: markFormattedBinding)
                }
            } onIncrement: {
                groundSpeedValue = windMarkStepperIncrement(value: groundSpeedValue)
            } onDecrement: {
                groundSpeedValue = windMarkStepperDecrement(value: groundSpeedValue)
            }
        }
    }
    
    private var markFormattedBinding: Binding<String> {
        Binding(
            get: { String(format: "%.2f", abs(groundSpeedValue * (isHighSpeed ? 5 : 1) )) },
            set: { newValue in
                if let value = Double(newValue),
                   isMarkInRange(value: value / (isHighSpeed ? 5 : 1))
                {
                    groundSpeedValue = value / (isHighSpeed ? 5 : 1)
                }
            }
        )
    }
    
    func isMarkInRange(value: Double) -> Bool {
        return windMarkRange().contains(value)
    }
    
    func step() -> Double {
//        unitHeight / cos(drift * .pi / 180)
//        unitHeight
        1
    }
    
    func windMarkRange() -> ClosedRange<CGFloat> {
        let aPoint: CGFloat = (170 - verticalOffset / unitHeight - 50)
        let bPoint: CGFloat = (170 - verticalOffset / unitHeight + 50)
        let range = aPoint...bPoint
        return range
    }
    
    func markOffsetCalculator() {
        markOffset.width = -groundSpeedValue * sin(drift * .pi / 180) * unitHeight
        markOffset.height = -(170 - verticalOffset/unitHeight - cos(-drift * .pi / 180) * groundSpeedValue) * unitHeight
    }

    func windMarkStepperIncrement(value: Double) -> Double {
        if windMarkRange().contains(value) {
            return value + 1
        }
        return windMarkRange().upperBound
    }
    
    func windMarkStepperDecrement(value: Double) -> Double {
        if windMarkRange().contains(value) {
            return value - 1
        }
        return windMarkRange().lowerBound
    }
}

#Preview {
    WindSideSimulatorView()
}
