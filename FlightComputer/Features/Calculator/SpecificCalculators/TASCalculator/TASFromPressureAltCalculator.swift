//
//  TrueAirSpeedCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import Foundation

struct TASFromPressureAltCalculator {
    var pressureAltitude: Double = 0  // Altitude in meters
    var outsideAirTemp: Double = 0  // OAT in °C
    var indicatedAirSpeed: Double = 0  // IAS in knots

    var pressureAltitudeUnit = Distance.feet // Unit for pressure altitude
    var outsideAirTempUnit = Temperature.celsius // Unit for outside air temperature
    var indicatedAirSpeedUnit = Speed.knots // Unit for indicated airspeed

    // Calculate True Airspeed (TAS)
    var trueAirSpeed: Double {
        calculateTAS()
    }
    
    private func calculatePressure() -> Double {
        let altitudeInMeters = pressureAltitudeUnit.convert(value: pressureAltitude, to: .meters)
        if altitudeInMeters < 11000 {
            return 101325 * pow(1 - 0.0000225577 * altitudeInMeters, 5.25588)
        } else {
            let result = 22632.1 * exp(-0.0001577 * (altitudeInMeters - 11000))
            return result
        }
    }
    
    private func calculateAirDensity() -> Double {
        let temp = outsideAirTempUnit.convert(value: outsideAirTemp, to: .kelvin)
        let result = (calculatePressure() / (287.05 * temp))
        return result
    }
    
    private func calculateTAS() -> Double {
        let result = indicatedAirSpeed / sqrt(calculateAirDensity() / 1.225)
        return result
    }
}
