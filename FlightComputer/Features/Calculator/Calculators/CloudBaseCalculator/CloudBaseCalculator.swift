//
//  CloudBaseCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import Foundation

struct CloudBaseCalculator {
    var ambientTemp: Double = 0  // Temperature in °C
    var ambientDewpoint: Double = 0  // Dewpoint in °C
    var stationAltitude: Double = 0 // Station altitude in meters
    
    var ambientTempUnit = Temperature.celsius
    var ambientDewpointUnit = Temperature.celsius
    var stationAltitudeUnit = Distance.feet
    
    var cloudBaseAltitude: Double {
        let calculatedAmbientTemp = ambientTempUnit.toCelcius(value: ambientTemp)
        let ambientDewpointTemp = ambientDewpointUnit.toCelcius(value: ambientDewpoint)
        let calculatedStationAlt = stationAltitudeUnit.convert(value: stationAltitude, to: .meters)
        
        let tempSpread = calculatedAmbientTemp - ambientDewpointTemp
        let baseHeight = tempSpread / 10 * 1247.0  // Height in meters above the station
        let cloudBaseAlt = calculatedStationAlt + baseHeight
        let targetAlt = Distance.meters.convert(value: cloudBaseAlt, to: stationAltitudeUnit)
        return targetAlt
    }
}
