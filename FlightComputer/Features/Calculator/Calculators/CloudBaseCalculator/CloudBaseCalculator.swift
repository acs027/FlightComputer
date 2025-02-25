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
    var stationAltitude: Double = 0  // Station altitude in meters

    var cloudBaseAltitude: Double {
        let lapseRate = 0.008  // °C per meter
        let tempSpread = ambientTemp - ambientDewpoint
        let baseHeight = tempSpread / lapseRate  // Height in meters above the station
        return stationAltitude + baseHeight
    }
}
