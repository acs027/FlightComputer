//
//  Density.swift
//  FlightComputer
//
//  Created by ali cihan on 27.02.2025.
//

import Foundation

enum Density: String, CaseIterable, Hashable, UnitType {
    case kilogramsPerCubicMeter = "kg/m³"
    case gramsPerCubicCentimeter = "g/cm³"
    case poundsPerCubicInch = "lb/in³"
    case poundsPerCubicFoot = "lb/ft³"
    case ouncesPerCubicInch = "oz/in³"
    case poundsPerUSGallon = "lb/US gal"
    case kilogramPerLiter = "kg/L"

    private var toKilogramsPerCubicMeter: Double {
        switch self {
        case .kilogramsPerCubicMeter:
            return 1.0
        case .gramsPerCubicCentimeter:
            return 1000.0
        case .poundsPerCubicInch:
            return 27679.9
        case .poundsPerCubicFoot:
            return 16.0185
        case .ouncesPerCubicInch:
            return 1729.99
        case .poundsPerUSGallon:
            return 0.00834
        case .kilogramPerLiter:
            return 0.001
        }
    }

    func convert(value: Double, to: Density) -> Double {
        if self == to { return value }
        let valueInKilogramsPerCubicMeter = value * toKilogramsPerCubicMeter
        return valueInKilogramsPerCubicMeter / to.toKilogramsPerCubicMeter
    }

    var symbol: String {
        self.rawValue
    }
}
