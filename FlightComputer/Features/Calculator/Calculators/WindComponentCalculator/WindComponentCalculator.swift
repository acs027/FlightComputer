//
//  WindComponentCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import Foundation

struct WindComponentCalculator {
    var windSpeed: Double = 0  // Wind speed in knots
    var windDirection: Double = 0  // Wind direction in degrees (from true north)
    var runwayHeading: Double = 0  // Runway direction in degrees (e.g., 270° for RWY 27)

    private var windAngle: Double {
        let angle = windDirection - runwayHeading
        return angle * .pi / 180  // Convert to radians
    }

    var headWind: Double {
        windSpeed * cos(windAngle)  // Headwind (+) / Tailwind (-)
    }

    var crossWind: Double {
        windSpeed * sin(windAngle)  // Left (-) / Right (+) crosswind
    }
}
