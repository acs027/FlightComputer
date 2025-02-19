//
//  Pressure.swift
//  FlightComputer
//
//  Created by ali cihan on 12.02.2025.
//

import Foundation

extension UnitConversion {
    enum Pressure: String, CaseIterable, Hashable, UnitType {
        case pascals = "Pa"
        case inchesOfMercury = "inHg"
        case millimetersOfMercury = "mmHg"
        case hectopascals = "hPa"
        case millibars = "mbar"
        case atmospheres = "atm"
        case poundsPerSquareInch = "psi"
        
        private var toPascals: Double {
            switch self {
            case .inchesOfMercury:
                return 3386.39
            case .millimetersOfMercury:
                return 133.322
            case .pascals:
                return 1
            case .hectopascals:
                return 100.0
            case .millibars:
                return 100.0
            case .atmospheres:
                return 101325.0
            case .poundsPerSquareInch:
                return 6894.76
            }
        }
        
        func convert(value: Double, to: Pressure) -> Double {
            if self == to { return value }
            // Convert the input value to pascals first
            let valueInPascals = value * toPascals
            return valueInPascals / to.toPascals
        }
        
        var symbol: String {
            self.rawValue
        }
    }
}
