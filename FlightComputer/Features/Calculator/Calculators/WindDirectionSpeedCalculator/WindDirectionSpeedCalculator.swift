//
//  WindDirectionSpeedCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import Foundation

struct WindDirectionSpeedCalculator {
    var heading: Double = 0 // Aircraft heading in degrees (from true north)
    var trueAirSpeed: Double = 0 // True Airspeed (TAS) in knots
    var trueCourse: Double = 0  // True course in degrees (from true north)
    var groundSpeed: Double = 0  // Ground speed in knots
    var windCorrectionAngle: Double = 0 // Wind correction angle (in degrees)

    // Calculate wind speed using ground speed, true airspeed, and wind correction angle
    var windSpeed: Double {
        sqrt(pow(trueAirSpeed, 2) + pow(groundSpeed, 2) - 2 * trueAirSpeed * groundSpeed * cos(windCorrectionAngle * .pi / 180))
    }

    // Calculate wind direction using true course and wind correction angle
    var windDirection: Double {
        let windAngle = trueCourse + windCorrectionAngle
        return windAngle.truncatingRemainder(dividingBy: 360)  // Ensure it's between 0° and 360°
    }
}
