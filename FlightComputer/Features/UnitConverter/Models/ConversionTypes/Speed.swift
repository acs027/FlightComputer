//
//  Speed.swift
//  FlightComputer
//
//  Created by ali cihan on 26.02.2025.
//

import Foundation

enum Speed: String, CaseIterable, Hashable, UnitType {
    case knots = "knots"
    case metersPerSecond = "m/s"
    case kilometersPerHour = "km/h"
    
    private var toKnots: Double {
        switch self {
        case .knots:
            return 1
        case .metersPerSecond:
            return 1.94384
        case .kilometersPerHour:
            return 0.539957
        }
    }
    
    func convert(value: Double, to: Speed) -> Double {
        if self == to { return value }
        // Convert the input value to knots first
        let valueInKnots = value * toKnots
        return valueInKnots / to.toKnots
    }
    
    var symbol: String {
        self.rawValue
    }
}
