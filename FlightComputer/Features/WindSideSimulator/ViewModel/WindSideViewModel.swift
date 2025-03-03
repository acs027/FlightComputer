//
//  WindSideViewModel.swift
//  FlightComputer
//
//  Created by ali cihan on 16.02.2025.
//

import Foundation


@Observable class WindSideViewModel {
    var wCACalculator = WindCorrectionAngleCalculator()
    var referenceHeight: Double = 0
    var unitHeight: Double {
        let height = referenceHeight * 0.83
        return height / 220
    }
    
    var results: [(label: String, value: Double, type: ValueType)] {
        [
        ("WD", wCACalculator.windDirection, .angle),
        ("WS", wCACalculator.windSpeed, .double),
        ("TC", wCACalculator.trueCourse, .angle),
        ("TAS", wCACalculator.trueAirSpeed, .double),
        ("WCA", wCACalculator.windCorrectionAngle ?? 0, .angle),
        ("GS", wCACalculator.groundSpeed ?? 0, .double)
        ]
    }
    
    var verticalRange: ClosedRange<CGFloat> {
        let highestPoint = unitHeight * 130
        let lowestPoint = -unitHeight * 90
        return lowestPoint...highestPoint
    }
    
    var markRange: ClosedRange<CGFloat> {
        let highestPoint: CGFloat = .zero
        let lowestPoint: CGFloat = -unitHeight * 50
        return lowestPoint...highestPoint
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
    
    func markStepperIncrement(value: Double) -> Double {
        if value > -unitHeight * 49 {
            return value - unitHeight
        }
        return -unitHeight * 50
    }
    
    func markStepperDecrement(value: Double) -> Double {
        if value < -unitHeight {
            return value + unitHeight
        }
        return 0
    }
    
    func calculateVerticalOffset(value: Double) -> Double {
        let verticalOffset = (170 - value) * unitHeight
        return verticalOffset
    }
    
    func calculateMarkOffset(value: Double) -> Double {
        let markOffset = -value * unitHeight
        return markOffset
    }
    
    func isVerticalOffsetInRange(value: Double) -> Bool {
        let highestPoint = unitHeight * 130
        let lowestPoint = -unitHeight * 90
        let range = lowestPoint...highestPoint
        let convertedValue = (170 - value) * unitHeight
        return range.contains(convertedValue)
    }
    
    func isAngleInRange(value: Double) -> Bool {
        let range: ClosedRange<Double> = 0...360
        return range.contains(value)
    }
    
    func isMarkInRange(value: Double) -> Bool {
        let highestPoint: Double = 0
        let lowestPoint = -unitHeight * 50
        let range = lowestPoint...highestPoint
        let convertedValue = -value * unitHeight
        return range.contains(convertedValue)
    }
    
    func setValue(for step: WCACalculationSteps, speedValue: Double, markValue: Double, angle: Double) {
        switch step {
        case .windDirection:
            wCACalculator.windDirection = angle
            print(wCACalculator.windDirection)
        case .windVelocity:
            wCACalculator.windSpeed = markValue
        case .trueCourse:
            wCACalculator.trueCourse = angle
        case .trueAirSpeed:
            wCACalculator.trueAirSpeed = speedValue + (wCACalculator.headWind?.rounded() ?? 0)
        case .result:
            print("result")
        }
    }
}
