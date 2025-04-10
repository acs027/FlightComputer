//
//  Temperature.swift
//  FlightComputer
//
//  Created by ali cihan on 12.02.2025.
//

import Foundation

enum Temperature: String, CaseIterable, Hashable, UnitType {
    case celsius = "C"
    case fahrenheit = "F"
    case kelvin = "K"
    
    func convert(value: Double, to: Temperature) -> Double {
        if self == to { return value }
        let valueInCelcius = toCelcius(value: value)
        
        switch (to) {
        case (.fahrenheit):
            return valueInCelcius*9/5 + 32
        case (.kelvin):
            return valueInCelcius + 273.15
        default:
            return valueInCelcius
        }
    }
    
    func toCelcius(value: Double) -> Double {
        switch self {
        case .fahrenheit:
            return (value - 32)*(5/9)
        case .kelvin:
            return value - 273.15
        default:
            return value
        }
    }
    
    var symbol: String {
        self.rawValue
    }
}

