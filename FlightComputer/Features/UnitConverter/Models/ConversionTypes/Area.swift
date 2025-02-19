//
//  Area.swift
//  FlightComputer
//
//  Created by ali cihan on 12.02.2025.
//

import Foundation

extension UnitConversion {
    enum Area: String, CaseIterable, Hashable, UnitType {
        case squareMeters = "m2"
        case squareMiles = "mi2"
        case squareFeet = "ft2"
        case squareInches = "in2"
        case squareKilometers = "km2"
        case acres = "ac"
        case hectares = "ha"
        
        private var toSquareMeters: Double {
            switch self {
            case .squareMiles:
                return 2_589_988.11
            case .squareFeet:
                return 0.092903
            case .squareInches:
                return 0.00064516
            case .squareKilometers:
                return 1_000_000
            case .squareMeters:
                return 1.0
            case .acres:
                return 4_046.86
            case .hectares:
                return 10_000
            }
        }
        
        func convert(value: Double, to: Area) -> Double {
            if self == to { return value }
            let valueInSquareMeters = value * toSquareMeters
            return valueInSquareMeters / to.toSquareMeters
        }
        
        var symbol: String {
            self.rawValue
        }
    }
}
