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
    
    // Constants
    private let seaLevelPressure: Double = 1013.25 // Sea-level pressure in hPa
    private let seaLevelTemp: Double = 288.15     // Standard temperature at sea level in Kelvin
    private let lapseRate: Double = 0.0019812     // Temperature lapse rate in K/ft
    private let gravitationalAccel: Double = 32.174 // Gravitational acceleration in ft/s²
    private let molarMassAir: Double = 0.0289644   // Molar mass of air in kg/mol
    private let gasConstant: Double = 8.3144598    // Universal gas constant in J/(mol·K)

    // Convert Celsius to Kelvin
    private func celsiusToKelvin(_ celsius: Double) -> Double {
        return celsius + 273.15
    }

    // Convert meters to feet (if needed)
    private func metersToFeet(_ meters: Double) -> Double {
        return meters * 3.28084
    }

    // Convert True Air Speed to knots if needed
    private func convertToKnots(_ tas: Double) -> Double {
        return tasUnit.convert(value: tas, to: .knots)
    }

    // Calculate pressure at altitude using the barometric formula
    private func pressureAtAltitude(_ altitudeFeet: Double, _ tempK: Double) -> Double {
        let exponent = (gravitationalAccel * molarMassAir) / (gasConstant * lapseRate)
        let pressureRatio = pow(1 - (lapseRate * altitudeFeet) / seaLevelTemp, exponent)
        return seaLevelPressure * pressureRatio
    }

    // Calculate density ratio (σ)
    private func densityRatio(_ pressure: Double, _ tempK: Double) -> Double {
        return (pressure / seaLevelPressure) * (seaLevelTemp / tempK)
    }

    // Calculate Indicated Airspeed (IAS) from TAS and density ratio
    private func indicatedAirspeed(_ tas: Double, _ densityRatio: Double) -> Double {
        return tas * sqrt(densityRatio)
    }

    // Main function to calculate IAS
    var indicatedAirSpeed: Double {
        // Convert inputs to consistent units
        let altitudeInFeet = altitudeUnit.convert(value: pressureAltitude, to: .feet)  // Convert altitude to feet
        let tempK = celsiusToKelvin(temperatureUnit.toCelcius(value: outsideAirTemp))   // Convert temperature to Kelvin
        let tasInKnots = convertToKnots(trueAirSpeed)  // Convert TAS to knots if needed

        // Calculate pressure at altitude
        let pressure = pressureAtAltitude(altitudeInFeet, tempK)

        // Calculate density ratio
        let sigma = densityRatio(pressure, tempK)

        // Calculate IAS
        let ias = indicatedAirspeed(tasInKnots, sigma)

        return ias
    }
}
