//
//  WindCalculationService.swift
//  FlightComputer
//
//  Created by ali cihan on 13.03.2025.
//

import Foundation

class CalculationService {
    var wCACalculator = WindCorrectionAngleCalculator()
    var courseCalculator = CourseCalculator()
    var windCalculator = WindDirectionSpeedCalculator()

    func setValues(for step: DriftTrackStep, speedValue: Double, markValue: Double, angle: Double) {
        switch step {
        case .tas:
            wCACalculator.trueAirSpeed = speedValue
        case .windDirection:
            wCACalculator.windDirection = angle
        case .windSpeed:
            wCACalculator.windSpeed = markValue
        case .track:
            wCACalculator.trueCourse = angle
        case .correction:
            return
        case .result:
            return
        }
    }

    func setValues(for step: DriftHeadingStep, speedValue: Double, markValue: Double, angle: Double) {
        switch step {
        case .tas:
            courseCalculator.trueAirSpeed = speedValue
        case .windDirection:
            courseCalculator.windDirection = angle
        case .windSpeed:
            courseCalculator.windSpeed = markValue
        case .heading:
            courseCalculator.heading = angle
        default:
            return
        }
    }
    
    func setValues(for step: WindCalculatorStep, speedValue: Double, markValue: Double, angle: Double) {
        switch step {
        case .tas:
            windCalculator.trueAirSpeed = speedValue
        case .track:
            windCalculator.trueCourse = angle
        case .heading:
            windCalculator.heading = angle
        case .groundSpeed:
            windCalculator.groundSpeed = markValue
        default:
            return
        }
    }
    
    
    
    func results(type: CalculationStepType) -> [(label: String, value: Double, type: ValueType)] {
        switch type {
        case .driftHeading(_):
            [
                ("WD", courseCalculator.windDirection, .angle),
                ("WS", courseCalculator.windSpeed, .double),
                ("H", courseCalculator.heading, .angle),
                ("TAS", courseCalculator.trueAirSpeed, .double),
                ("WCA", courseCalculator.windCorrectionAngle, .angle),
                ("GS", courseCalculator.groundSpeed, .double)
            ]
        case .driftTrack(_):
            [
                ("WD", wCACalculator.windDirection, .angle),
                ("WS", wCACalculator.windSpeed, .double),
                ("TC", wCACalculator.trueCourse, .angle),
                ("TAS", wCACalculator.trueAirSpeed, .double),
                ("WCA", wCACalculator.windCorrectionAngle, .angle),
                ("GS", wCACalculator.groundSpeed, .double)
            ]
        case .windCalculator(_):
            [
                ("TAS", windCalculator.trueAirSpeed, .double),
                ("H", windCalculator.heading, .angle),
                ("TC", windCalculator.trueCourse, .angle),
                ("GS", windCalculator.groundSpeed, .double),
                ("WD", windCalculator.windDirection, .angle),
                ("WS", windCalculator.windSpeed, .double)
            ]
        }
       
    }
}
