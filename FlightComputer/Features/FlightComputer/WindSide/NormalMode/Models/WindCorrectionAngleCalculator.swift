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
    private var windAngle: Double {
        return windDirection - trueCourse
    }
    
    var headWind: Double {
        return windSpeed * cos( windAngle / 180 * .pi )
    }
    
    var crossWind: Double {
        return windSpeed * sin( windAngle / 180 * .pi )
    }
    var windCorrectionAngle: Double {
        if trueAirSpeed == 0 { return 0 }
        let result = asin(crossWind / trueAirSpeed) * 180 / .pi
        return result
    }
    
    var groundSpeed: Double {
        let result = trueAirSpeed - headWind
        return result
    }
    
    var heading: Double {
        return trueCourse + windCorrectionAngle
    }
    
    mutating func reset() {
        trueCourse = 0
        trueAirSpeed = 0
        windDirection = 0
        windSpeed = 0
    }
}

