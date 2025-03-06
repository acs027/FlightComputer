//
//  GroundSpeedCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 12.02.2025.
//

import Foundation

struct FlightTimeCalculator {
    var distance: Double = 0
    var groundSpeed: Double = 0
    var flightTime: Double {
        if distance > 0,
           groundSpeed > 0 {
            return (distance / groundSpeed) * 3600
        }
        else {
            return 0
        }
    }
}
