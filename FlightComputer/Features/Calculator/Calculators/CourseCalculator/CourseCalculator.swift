//
//  CourseCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 12.02.2025.
//

import Foundation

//struct CourseCalculator {
//    var heading: Double = 0
//    var trueAirSpeed: Double = 0
//    var windDirection: Double = 0
//    var windSpeed: Double = 0
//    private var windAngle: Double? {
//        return windDirection - heading
//    }
//    
//    var headWind: Double? {
//        guard let windAngle = windAngle else { return nil }
//        return windSpeed * cos( windAngle / 180 * .pi )
//    }
//    
//    var crossWind: Double? {
//        guard let windAngle = windAngle else { return nil }
//        return windSpeed * sin( windAngle / 180 * .pi )
//    }
//    
//    var trueCourse: Double? {
//        guard let windCorrectionAngle = windCorrectionAngle else { return nil }
//        return windCorrectionAngle + heading
//    }
//    
//    var windCorrectionAngle: Double? {
//        guard let crossWind = crossWind
//        else { return nil }
//        let result = asin(crossWind / trueAirSpeed) * 180 / .pi
//        return result
//    }
//    
//    var groundSpeed: Double? {
//        guard let headWind = headWind
//        else { return nil }
//        let result = trueAirSpeed - headWind
//        return result
//    }
//}

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
}
