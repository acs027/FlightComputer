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
    
    private var headWind: Double {
        let ySpeed = groundSpeed * cos(trueCourse * .pi / 180) - trueAirSpeed * cos(heading * .pi / 180)
        return ySpeed
    }
    
    private var crossWind: Double {
        let xSpeed = groundSpeed * sin(trueCourse * .pi / 180) - trueAirSpeed * sin(heading * .pi / 180)
        return xSpeed
    }
    
    // Computed property for wind speed
    var windSpeed: Double {
        let windSpeed = sqrt(pow(headWind, 2) + pow(crossWind, 2))
        return windSpeed
    }
    
    // Computed property for wind direction
    var windDirection: Double {
        // Wind correction angle (WCA) approximation
        let angle =  atan2(-crossWind , -headWind) * 180 / .pi
        return (angle + 360).truncatingRemainder(dividingBy: 360)
    }
    
    mutating func reset() {
        trueCourse = 0
        trueAirSpeed = 0
        heading = 0
        groundSpeed = 0
    }
}
