//
//  Volume.swift
//  FlightComputer
//
//  Created by ali cihan on 12.02.2025.
//

import Foundation

enum Volume: String, CaseIterable, Hashable, UnitType {
    case liters = "L"
    case gallonsUS = "gal (US)"
    case gallonsImp = "gal (UK)"
    case milliliters = "mL"
    case quartsUS = "qt (US)"
    case quartsImp = "qt (UK)"
    
    private var toLiters: Double {
        switch self {
        case .liters:
            return 1.0
        case .gallonsUS:
            return 3.78541
        case .gallonsImp:
            return 4.54609
        case .milliliters:
            return 0.001
        case .quartsUS:
            return 0.946353
        case .quartsImp:
            return 1.13652
        }
    }
    
    func convert(value: Double, to: Volume) -> Double {
        if self == to { return value }
        let valueInLiters = value * toLiters
        return valueInLiters / to.toLiters
    }
    
    var symbol: String {
        self.rawValue
    }
}


