//
//  Distance.swift
//  FlightComputer
//
//  Created by ali cihan on 12.02.2025.
//

import Foundation

extension UnitConversion {
    enum Distance: String, CaseIterable, Hashable, UnitType {
        case nauticalMiles = "NM"
        case statuteMiles = "mi"
        case kilometers = "km"
        case meters = "m"
        case feet = "ft"
        case yards = "yd"
        
        private var toMeters: Double {
            switch self {
            case .nauticalMiles:
                return 1852.0
            case .statuteMiles:
                return 1609.34
            case .kilometers:
                return 1000.0
            case .meters:
                return 1
            case .feet:
                return 1 / 3.28084
            case .yards:
                return 1 / 1.09361
            }
        }
        
        func convert(value: Double, to: Distance) -> Double {
            // Convert the input value to meters first
            if self == to { return value }
            let valueInMeters = value * toMeters
            return valueInMeters / to.toMeters
        }
        
        var symbol: String {
            self.rawValue
        }
        
    }
}

