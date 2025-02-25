//
//  DewpointCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import Foundation

struct DewpointCalculator {
    var airTemp: Double = 0  // Air temperature in °C
    var relativeHumidity: Double = 0  // Relative humidity in %

    var dewpoint: Double? {
        guard relativeHumidity > 0, relativeHumidity <= 100 else { return nil }  // Ensure valid RH range
        
        let alpha = 17.27
        let beta = 237.7
        let intermediateValue = (alpha * airTemp) / (beta + airTemp) + log(relativeHumidity / 100)
        
        return (beta * intermediateValue) / (alpha - intermediateValue)
    }
}
