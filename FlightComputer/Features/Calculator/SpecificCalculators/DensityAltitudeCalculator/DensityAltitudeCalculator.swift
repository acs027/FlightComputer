//
//  DensityAltitudeCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import Foundation

struct DensityAltitudeCalculator {
    var pressureAltitude: Double = 0  // Pressure Altitude in feet
    var oat: Double = 0  // Outside Air Temperature (OAT) in °C
    var trueAltitude: Double = 0
    
    var pressureAltitudeUnit = Distance.feet
    var oatUnit = Temperature.celsius
    
    var isaTemp: Double {
        let altitudeInMeters = pressureAltitudeUnit.convert(value: trueAltitude, to: .meters)
        var tempKelvin: Double = 0
        if altitudeInMeters < 11000 {
            tempKelvin = 288.15 - 0.00649 * altitudeInMeters
        } else {
            tempKelvin = -56.5
        }
        return Temperature.kelvin.convert(value: tempKelvin, to: oatUnit)
    }

    // Density Altitude Calculation
    var densityAltitude: Double {
        let altitudeInFeet = pressureAltitudeUnit.convert(value: pressureAltitude, to: .feet)
        let oatInCelsius = oatUnit.toCelcius(value: oat)
        let isaTempCelsius = oatUnit.toCelcius(value: isaTemp)
        let densityAltInFeet = altitudeInFeet + 118.8 * (oatInCelsius - isaTempCelsius)
        return Distance.feet.convert(value: densityAltInFeet, to: pressureAltitudeUnit)
    }
}
