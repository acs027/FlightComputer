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

    var airTempUnit = Temperature.celsius
    
    // Dewpoint Calculation
    var dewpoint: Double? {
        guard relativeHumidity > 0, relativeHumidity <= 100 else { return nil }  // Ensure valid RH range
        
        let airTempInCelsius = airTempUnit.toCelcius(value: airTemp)
        let alpha = 17.27
        let beta = 237.7
        let intermediateValue = (alpha * airTempInCelsius) / (beta + airTempInCelsius) + log(relativeHumidity / 100)
        
        let dewPointCelsius = (beta * intermediateValue) / (alpha - intermediateValue)
        return Temperature.celsius.convert(value: dewPointCelsius, to: airTempUnit)
    }
}
