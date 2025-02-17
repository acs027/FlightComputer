//
//  Mass.swift
//  FlightComputer
//
//  Created by ali cihan on 12.02.2025.
//

import Foundation

extension UnitConversion {
    enum Mass: String, CaseIterable, Hashable, UnitType {
        case kilograms = "kg"
        case grams = "g"
        case pounds = "lb"
        case ounces = "oz"
        case metricTons = "t"
        case ukStones = "st"
        
        private var toKilograms: Double {
            switch self {
            case .kilograms:
                return 1
            case .grams:
                return 1 / 1000.0
            case .pounds:
                return 1 / 2.20462
            case .ounces:
                return 1 / 35.274
            case .metricTons:
                return 1 * 1000.0
            case .ukStones:
                return 1 / 0.157473
            }
        }
        
        func convert(value: Double, to: Mass) -> Double {
            if self == to { return value }
            // Convert the input value to kilograms first
            let valueInKilograms = value * toKilograms
            return valueInKilograms / to.toKilograms
        }
        
        var symbol: String {
            self.rawValue
        }
    }
}
