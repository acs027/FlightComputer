//
//  CourseCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 12.02.2025.
//

import Foundation

struct CourseCalculator {
    var heading: Double = 0  // Aircraft heading in degrees (°)
    var trueAirSpeed: Double = 0  // True Airspeed (TAS) in knots
    var windDirection: Double = 0 // Wind direction (°) (where it's coming from)
    var windSpeed: Double = 0  // Wind speed in knots
    
    // Wind Angle (relative to the aircraft)
    private var windAngle: Double {
        let angle = windDirection - heading
        return angle.truncatingRemainder(dividingBy: 360)  // Keep within 0° to 360°
    }
    
    // Headwind Component
    var headWind: Double {
        return windSpeed * cos(windAngle * .pi / 180)
    }
    
    // Crosswind Component
    var crossWind: Double {
        return windSpeed * sin(windAngle * .pi / 180)
    }
    
    // Wind Correction Angle (WCA)
    var windCorrectionAngle: Double {
        let correctionAngle = atan2(crossWind, trueAirSpeed) * 180 / .pi
        return correctionAngle
    }
    
    // True Course
    var trueCourse: Double {
        return heading + windCorrectionAngle
    }
    
    // Ground Speed (GS)
    var groundSpeed: Double {
        return sqrt(pow(trueAirSpeed - headWind, 2) + pow(crossWind, 2))
    }
    
    mutating func reset() {
        heading = 0
        trueAirSpeed = 0
        windDirection = 0
        windSpeed = 0
    }
}
