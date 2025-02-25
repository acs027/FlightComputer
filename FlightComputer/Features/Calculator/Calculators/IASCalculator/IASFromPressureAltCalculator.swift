//
//  IndicatedAirSpeedCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import Foundation


struct IASFromPressureAltCalculator {
    var pressureAltitude: Double = 0  // Altitude in meters
    var outsideAirTemp: Double = 0  // OAT in °C
    var trueAirSpeed: Double = 0  // TAS in knots

    private let seaLevelPressure = 1013.25  // hPa (Standard sea-level pressure)
    private let seaLevelDensity = 1.225  // kg/m³ (ISA air density at sea level)
    private let tempLapseRate = 0.0065  // °C per meter
    private let seaLevelTempK = 288.15  // Kelvin (ISA standard sea-level temp)

    // Air Density at Altitude (ISA Model)
    private var airDensity: Double {
        let tempAtAltitude = seaLevelTempK - (tempLapseRate * pressureAltitude)  // Temperature at altitude in Kelvin
        let pressureAtAltitude = seaLevelPressure * pow((1 - (tempLapseRate * pressureAltitude / seaLevelTempK)), 5.256)
        return pressureAtAltitude / (287.05 * tempAtAltitude)  // Ideal Gas Law: ρ = P / (R × T)
    }

    // Indicated Airspeed (IAS) Calculation
    var indicatedAirSpeed: Double {
        trueAirSpeed * sqrt(airDensity / seaLevelDensity)
    }
}
