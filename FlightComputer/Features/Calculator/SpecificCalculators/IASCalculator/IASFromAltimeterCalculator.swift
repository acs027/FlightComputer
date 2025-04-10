//
//  IASFromAltimeterCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import Foundation

struct IASFromAltimeterCalculator {
    var indicatedAltitude: Double = 0  // Indicated Altitude (ft or m)
    var altimeterSetting: Double = 29.92 // Altimeter Setting (inHg or hPa)
    var outsideAirTemp: Double = 0 // Outside Air Temperature in °C
    var trueAirSpeed: Double = 0 // True Air Speed (TAS) in knots
    
    var altitudeUnit = Distance.feet
    var temperatureUnit = Temperature.celsius
    var pressureUnit = Pressure.inchesOfMercury  // Altimeter setting unit (inHg, hPa, etc.)
    var tasUnit = Speed.knots  // True Air Speed unit (knots, m/s, etc.)
    
    // Constants
    private let seaLevelPressure = 1013.25 // Sea level pressure in hPa (1013.25 hPa = 29.92 inHg)
    private let lapseRate = 0.0065 // Temperature lapse rate in K/m
    private let seaLevelTemp = 288.15 // Standard temperature at sea level in Kelvin
    
    // Convert the altitude and pressure to pressure altitude
    private var pressureAltitude: Double {
        let altitudeInMeters = altitudeUnit.convert(value: indicatedAltitude, to: .meters)
        let pressureInPascals = pressureUnit.convert(value: altimeterSetting, to: .pascals)
        return (pressureInPascals - seaLevelPressure) * 100 + altitudeInMeters
    }
    
    // Convert indicated altitude to density altitude
    private var densityAltitude: Double {
        let isaTemp = 15.0 + (lapseRate * pressureAltitude)
        let oatInCelsius = temperatureUnit.toCelcius(value: outsideAirTemp)
        let tempDifference = oatInCelsius - isaTemp
        return pressureAltitude + (118.8 * tempDifference)
    }
    
    // Calculate Indicated Air Speed (IAS)
    var indicatedAirSpeed: Double {
        let oatInKelvin = temperatureUnit.convert(value: outsideAirTemp, to: .kelvin) // Convert to Kelvin
        let correctionFactor = sqrt((oatInKelvin / seaLevelTemp) * (seaLevelPressure / 1013.25))
        
        // Convert TAS to knots if needed
        let tasInKnots = tasUnit.convert(value: trueAirSpeed, to: .knots)
        
        return tasInKnots * correctionFactor
    }
}
