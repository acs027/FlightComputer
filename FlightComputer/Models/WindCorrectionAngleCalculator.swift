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
        return windDirection - trueCourse
    }
    
    var headWind: Double? {
        guard let windAngle = windAngle else { return nil }
        return windSpeed * cos( windAngle / 180 * .pi )
    }
    
    var crossWind: Double? {
        guard let windAngle = windAngle else { return nil }
        return windSpeed * sin( windAngle / 180 * .pi )
    }
    var windCorrectionAngle: Double? {
        guard let crossWind = crossWind
        else { return nil }
        let result = asin(crossWind / trueAirSpeed) * 180 / .pi
        return result
    }
    
    var groundSpeed: Double? {
        guard let headWind = headWind
        else { return nil }
        let result = trueAirSpeed - headWind
        return result
    }
    
    var heading: Double? {
        guard let windCorrectionAngle = windCorrectionAngle else { return nil }
        return trueCourse + windCorrectionAngle
    }
}

