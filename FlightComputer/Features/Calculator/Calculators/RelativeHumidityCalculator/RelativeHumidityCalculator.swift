//
//  RelativeHumidityCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import Foundation

struct RelativeHumidityCalculator {
    var airTemp: Double = 0  // Air temperature in °C
    var dewpoint: Double = 0  // Dewpoint in °C

    var relativeHumidity: Double {
        let A = 6.112  // Constant for vapor pressure calculation
        let B = 17.62
        let C = 243.5

        let exponentAirTemp = (B * airTemp) / (C + airTemp)
        let exponentDew = (B * dewpoint) / (C + dewpoint)

        let vaporPressureAtTemp = A * pow(10.0, exponentAirTemp)
        let vaporPressureAtDew = A * pow(10.0, exponentDew)

        return (vaporPressureAtDew / vaporPressureAtTemp) * 100
    }
}
