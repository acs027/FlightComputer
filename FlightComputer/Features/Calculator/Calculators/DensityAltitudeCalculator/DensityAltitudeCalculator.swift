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
    
    // ISA Temperature at the given pressure altitude
    var isaTemp: Double {
        let seaLevelTempC = 15.0  // ISA sea-level temperature in °C
        let lapseRate = -1.98 / 1000  // Lapse rate in °C per foot (-1.98°C per 1000 ft)
        let altitudeInMeters = pressureAltitudeUnit.convert(value: trueAltitude, to: .meters)
        let isaTemp = seaLevelTempC + (lapseRate * altitudeInMeters / 0.3048)  // Convert feet to meters for calculation
        return Temperature.celsius.convert(value: isaTemp, to: oatUnit)
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
