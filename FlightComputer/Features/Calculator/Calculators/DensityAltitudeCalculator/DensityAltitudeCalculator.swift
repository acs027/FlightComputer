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

    // ISA Temperature at the given pressure altitude
    var isaTemp: Double {
        let seaLevelTempC = 15.0  // ISA sea-level temperature in °C
        let lapseRate = -1.98 / 1000  // Lapse rate in °C per foot (-1.98°C per 1000 ft)
        return seaLevelTempC + (lapseRate * pressureAltitude)
    }

    // Density Altitude Calculation
    var densityAltitude: Double {
        return pressureAltitude + 120 * (oat - isaTemp)
    }
}
