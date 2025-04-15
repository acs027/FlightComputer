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
        
    // Calculate True Air Speed (TAS)
    var trueAirSpeed: Double {
        calculateTAS()
    }
    
    var pressureAltitude: Double {
        calculatePressureAltitude()
    }
    
    var densityAltitude: Double {
        calculateDensityAltitude()
    }
    
    private func calculatePressure() -> Double {
        let altitudeInMeters = indicatedAltitudeUnit.convert(value: indicatedAltitude, to: .meters)
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
    
    private func calculatePressureAltitude() -> Double {
        var calculator = PressureAltitudeCalculator()
        calculator.fieldElevationUnit = indicatedAltitudeUnit
        calculator.altimeterSettingUnit = altimeterSettingUnit
        calculator.altimeterSetting = altimeterSetting
        calculator.fieldElevation = indicatedAltitude
        return calculator.pressureAltitude
    }
    
    private func calculateDensityAltitude() -> Double {
        var calculator = DensityAltitudeCalculator()
        calculator.oatUnit = outsideAirTempUnit
        calculator.pressureAltitudeUnit = indicatedAltitudeUnit
        calculator.oat = outsideAirTemp
        calculator.pressureAltitude = calculatePressureAltitude()
        calculator.trueAltitude = indicatedAltitude
        return calculator.densityAltitude
    }
}
