//
//  TASFromAltimeterCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import Foundation

struct TASFromAltimeterCalculator {
    var indicatedAltitude: Double = 0 // Indicated Altitude (ft or m)
    var altimeterSetting: Double = 29.92 // Altimeter Setting (in/hg or hpa)
    var outsideAirTemp: Double = 0 // Outside Air Temperature in °C
    var indicatedAirSpeed: Double = 0 // Indicated Air Speed (IAS) in knots

    var indicatedAltitudeUnit = Distance.feet // Unit for indicated altitude
    var altimeterSettingUnit = Pressure.inchesOfMercury // Unit for altimeter setting
    var outsideAirTempUnit = Temperature.celsius // Unit for outside air temperature
    var indicatedAirSpeedUnit = Speed.knots // Unit for indicated airspeed

    // Constants
    private let seaLevelPressure = 1013.25 // Sea level pressure in hPa (1013.25 hPa = 29.92 inHg)
    private let lapseRate = 0.0065 // Temperature lapse rate in K/m
    private let seaLevelTemp = 288.15 // Standard temperature at sea level in Kelvin
    
    // Convert the altitude and pressure to pressure altitude
    private var pressureAltitude: Double {
        let altitudeInMeters = indicatedAltitudeUnit.convert(value: indicatedAltitude, to: .meters)
        let pressureAltitudeInMeters = (29.92 - altimeterSetting) * 1000 + altitudeInMeters
        return indicatedAltitudeUnit.convert(value: pressureAltitudeInMeters, to: .feet) // Convert back to feet if necessary
    }
    
    // Convert indicated altitude to density altitude
    private var densityAltitude: Double {
        let isaTemp = 15.0 + (lapseRate * pressureAltitude) // ISA temperature at pressure altitude
        let tempDifference = outsideAirTempUnit.toCelcius(value: outsideAirTemp) - isaTemp
        return pressureAltitude + (118.8 * tempDifference)
    }
    
    // Calculate True Air Speed (TAS)
    var trueAirSpeed: Double {
        let temperatureAtAltitude = outsideAirTempUnit.convert(value: outsideAirTemp, to: .kelvin) // Convert to Kelvin
        let correctionFactor = sqrt((seaLevelTemp / temperatureAtAltitude) * (seaLevelPressure / 1013.25))
        return indicatedAirSpeedUnit.convert(value: indicatedAirSpeed, to: .knots) * correctionFactor
    }
}
