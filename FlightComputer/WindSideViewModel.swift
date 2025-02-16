//
//  WindSideViewModel.swift
//  FlightComputer
//
//  Created by ali cihan on 16.02.2025.
//

import Foundation


@Observable class WindSideViewModel {
    var wCACalculator = WindCorrectionAngleCalculator()
    
    
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
            wCACalculator.trueAirSpeed = speedValue
        case .result:
            print("result")
        }
    }
}
