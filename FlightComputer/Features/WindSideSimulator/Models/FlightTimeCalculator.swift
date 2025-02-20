//
//  GroundSpeedCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 12.02.2025.
//

import Foundation

struct FlightTimeCalculator {
    var distance: Double?
    var groundSpeed: Double?
    var flightTime: Double? {
        guard let distance = distance,
              let groundSpeed = groundSpeed else { return nil }
        return (distance / groundSpeed) * 60
    }
}
