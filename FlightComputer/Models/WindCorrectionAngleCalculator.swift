//
//  WindCorrectionCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 12.02.2025.
//

import Foundation

struct WindCorrectionAngleCalculator {
    var trueCourse: Double = 0
    var trueAirSpeed: Double = 0
    var windDirection: Double = 0
    var windSpeed: Double = 0
    private var windAngle: Double? {
//        guard let windDirection = windDirection,
//              let trueCourse = trueCourse else { return nil }
        return windDirection - trueCourse
    }
    var windCorrectionAngle: Double? {
        guard let windAngle = windAngle
//           let trueAirSpeed = trueAirSpeed,
//              let windSpeed = windSpeed
        else { return nil }
        let result = asin(windSpeed * sin(windAngle / 180 * Double.pi) / trueAirSpeed)*180/Double.pi
        return result
    }
    
    var groundSpeed: Double? {
//        guard let trueAirSpeed = trueAirSpeed,
//           let windSpeed = windSpeed,
//           let windAngle = windAngle else { return nil }
        guard let windAngle = windAngle else { return nil }
        let result = (pow(trueAirSpeed, 2) - pow(windSpeed, 2) * sin(windAngle / 180 * Double.pi)).squareRoot() + windSpeed * cos(windAngle / 180 * Double.pi)
        return result
    }
    
    var heading: Double? {
//        guard let trueCourse = trueCourse,
        guard let windCorrectionAngle = windCorrectionAngle else { return nil }
        return trueCourse + windCorrectionAngle
    }
}

