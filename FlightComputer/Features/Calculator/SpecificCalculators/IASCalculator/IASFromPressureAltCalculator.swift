//
//  IndicatedAirSpeedCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import Foundation


struct IASFromPressureAltCalculator {
    // Input properties
    var pressureAltitude: Double = 0 // Altitude in feets (default)
    var outsideAirTemp: Double = 0  // OAT in °C
    var trueAirSpeed: Double = 0    // TAS in knots

    // Units for each input
    var altitudeUnit = Distance.feet
    var temperatureUnit = Temperature.celsius
    var tasUnit = Speed.knots
    
    // Main function to calculate IAS
    var indicatedAirSpeed: Double {
        calculateIAS()
    }
    
    private func calculatePressure() -> Double {
        let altitudeInMeters = altitudeUnit.convert(value: pressureAltitude, to: .meters)
        if altitudeInMeters < 11000 {
            return 101325 * pow(1 - 0.0000225577 * altitudeInMeters, 5.25588)
        } else {
            let result = 22632.1 * exp(-0.0001577 * (altitudeInMeters - 11000))
            return result
        }
    }
    
    private func calculateAirDensity() -> Double {
        let temp = temperatureUnit.convert(value: outsideAirTemp, to: .kelvin)
        let result = (calculatePressure() / (287.05 * temp))
        return result
    }
    
    private func calculateIAS() -> Double {
        let result = trueAirSpeed * sqrt(calculateAirDensity() / 1.225)
        return result
    }
}
