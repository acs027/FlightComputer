//
//  IASFromAltimeterCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import Foundation

struct IASFromAltimeterCalculator {
    var indicatedAltitude: Double = 0 // Indicated Altitude (ft or m)
    var altimeterSetting: Double = 29.92 // Altimeter Setting (in/hg or hpa)
    var outsideAirTemp: Double = 0 // Outside Air Temperature in °C
    var trueAirSpeed: Double = 0 // True Air Speed (TAS) in knots
    
    // Constants
    private let seaLevelPressure = 1013.25 // Sea level pressure in hPa (1013.25 hPa = 29.92 inHg)
    private let lapseRate = 0.0065 // Temperature lapse rate in K/m
    private let seaLevelTemp = 288.15 // Standard temperature at sea level in Kelvin
    
    // Convert the altitude and pressure to pressure altitude
    private var pressureAltitude: Double {
        return (29.92 - altimeterSetting) * 1000 + indicatedAltitude
    }
    
    // Convert indicated altitude to density altitude
    private var densityAltitude: Double {
        let isaTemp = 15.0 + (lapseRate * pressureAltitude)
        let tempDifference = outsideAirTemp - isaTemp
        return pressureAltitude + (118.8 * tempDifference)
    }
    
    // Calculate Indicated Air Speed (IAS)
    var indicatedAirSpeed: Double {
        let temperatureAtAltitude = outsideAirTemp + 273.15 // Convert to Kelvin
//        let standardTemperatureAtAltitude = seaLevelTemp - (lapseRate * pressureAltitude)
        let correctionFactor = sqrt((temperatureAtAltitude / seaLevelTemp) * (seaLevelPressure / 1013.25))
        return trueAirSpeed * correctionFactor
    }
}
