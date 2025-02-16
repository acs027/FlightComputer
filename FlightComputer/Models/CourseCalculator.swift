//
//  CourseCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 12.02.2025.
//

import Foundation

struct CourseCalculator {
    var heading: Double?
    var trueAirSpeed: Double?
    var windDirection: Double?
    var windSpeed: Double?
    private var windAngle: Double? {
        guard let windDirection = windDirection,
              let heading = heading else { return nil }
        return windDirection - heading
    }
    var course: Double? {
        guard let heading = heading,
              let windCorrectionAngle = windCorrectionAngle else { return nil }
        return heading - windCorrectionAngle
    }
    var groundSpeed: Double? {
        guard let trueAirSpeed = trueAirSpeed,
           let windSpeed = windSpeed,
           let windAngle = windAngle else { return nil }
        let result = (pow(trueAirSpeed, 2) - pow(windSpeed, 2) * sin(windAngle / 180 * Double.pi)).squareRoot() + windSpeed * cos(windAngle / 180 * Double.pi)
        return result
    }
    var windCorrectionAngle: Double? {
        guard let windAngle = windAngle,
           let trueAirSpeed = trueAirSpeed,
              let windSpeed = windSpeed else { return nil }
        let result = asin(windSpeed * sin(windAngle / 180 * Double.pi) / trueAirSpeed)*180/Double.pi
        return result
    }
}
