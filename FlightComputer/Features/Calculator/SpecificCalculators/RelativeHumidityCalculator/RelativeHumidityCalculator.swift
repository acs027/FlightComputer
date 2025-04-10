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

    var tempUnit = Temperature.celsius

    var relativeHumidity: Double {
        let B = 17.625
        let C = 243.04

        let airTempInCelsius = tempUnit.toCelcius(value: airTemp)
        let dewpointInCelsius = tempUnit.toCelcius(value: dewpoint)

        let exponentAirTemp = (B * airTempInCelsius) / (C + airTempInCelsius)
        let exponentDew = (B * dewpointInCelsius) / (C + dewpointInCelsius)

        let vaporPressureAtTemp = exp(exponentAirTemp)
        let vaporPressureAtDew = exp(exponentDew)

        return (vaporPressureAtDew / vaporPressureAtTemp) * 100
    }
}
