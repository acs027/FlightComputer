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

    private let seaLevelPressure = 1013.25  // hPa (Standard sea-level pressure)
    private let seaLevelTemp = 288.15  // Kelvin (ISA standard sea-level temperature)
    private let tempLapseRate = 0.0065  // °C per meter
    private let exponent = 5.2561  // Corrected exponent for ISA pressure formula

    // Calculate pressure at altitude (ISA model)
    private var pressureAtAltitude: Double {
        seaLevelPressure * pow((1 - (tempLapseRate * pressureAltitude / seaLevelTemp)), exponent)
    }

    // Calculate temperature at altitude (ISA model)
    private var temperatureAtAltitude: Double {
        seaLevelTemp - (tempLapseRate * pressureAltitude)
    }

    // Calculate True Airspeed (TAS)
    var trueAirSpeed: Double {
        indicatedAirSpeed * sqrt(temperatureAtAltitude / seaLevelTemp * seaLevelPressure / pressureAtAltitude)
    }
}
