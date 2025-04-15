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
    var altimeterUnit = Pressure.inchesOfMercury  // Altimeter setting unit (inHg, hPa, etc.)
    var tasUnit = Speed.knots  // True Air Speed unit (knots, m/s, etc.)
    
    // Constants
    private let seaLevelPressure = 1013.25 // Sea level pressure in hPa (1013.25 hPa = 29.92 inHg)
    private let lapseRate = 0.0065 // Temperature lapse rate in K/m
    private let seaLevelTemp = 288.15 // Standard temperature at sea level in Kelvin
    
    // Convert the altitude and pressure to pressure altitude
    var pressureAltitude: Double {
        calculatePressureAltitude()
    }
    
    // Convert indicated altitude to density altitude
    var densityAltitude: Double {
        calculateDensityAltitude()
    }
    
    // Calculate Indicated Air Speed (IAS)
    var indicatedAirSpeed: Double {
        calculateIAS()
    }
    
    private func calculatePressure() -> Double {
        let altitudeInMeters = altitudeUnit.convert(value: indicatedAltitude, to: .meters)
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
    
    private func calculatePressureAltitude() -> Double {
        var calculator = PressureAltitudeCalculator()
        calculator.fieldElevationUnit = altitudeUnit
        calculator.altimeterSettingUnit = altimeterUnit
        calculator.altimeterSetting = altimeterSetting
        calculator.fieldElevation = indicatedAltitude
        return calculator.pressureAltitude
    }
    
    private func calculateDensityAltitude() -> Double {
        var calculator = DensityAltitudeCalculator()
        calculator.oatUnit = temperatureUnit
        calculator.pressureAltitudeUnit = altitudeUnit
        calculator.oat = outsideAirTemp
        calculator.pressureAltitude = calculatePressureAltitude()
        calculator.trueAltitude = indicatedAltitude
        return calculator.densityAltitude
    }
}
