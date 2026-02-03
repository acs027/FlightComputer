//
//  FuelMassCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 2.02.2026.
//

import Foundation

enum FuelType: Hashable {
    case avgas
    case jetAOne
    case jetB
    case other(density: Double)

    // Manual labels to replace the RawValue
    var label: String {
        switch self {
        case .avgas: return "Avgas (6 lb / US Gal)"
        case .jetAOne: return "Jet A1 (6.7 lb / US gal)"
        case .jetB: return "Jet B (6.5 lb / US gal)"
        case .other: return "Other"
        }
    }

    var densityPoundsPerGallon: Double {
        switch self {
        case .avgas: return 6.0
        case .jetAOne: return 6.7
        case .jetB: return 6.5
        case .other(let density): return density
        }
    }
    
    var densityKilogramPerLiter: Double {
        switch self {
        case .avgas:
            return calculatedDensity(value: 6)
        case .jetAOne:
            return calculatedDensity(value: 6.7)
        case .jetB:
            return calculatedDensity(value: 6.5)
        case .other(let density): return density
        }
    }
    
    private func calculatedDensity(value: Double) -> Double {
        let volumeMultiplier = Volume.gallonsUS.convert(value: 1, to: .liters)
        let massMultiplier = Mass.pounds.convert(value: 1, to: .kilograms)
        return value * massMultiplier / volumeMultiplier
    }
}

extension FuelType {
    static var allPresets: [FuelType] {
        return [.avgas, .jetAOne, .jetB, .other(density: 0.0)]
    }
}

struct FuelMassCalculator {
    var density: Double = 0 {
        didSet {
            calculateMass()
        }
    }
    var volume: Double = 0 {
        didSet {
            calculateMass()
        }
    }
    var mass: Double = 0
    
    var fuelType: FuelType = .avgas {
        didSet {
           setDensity()
        }
    }
    var fuelTypeUnit: Density = .poundsPerUSGallon {
        didSet {
           setDensity()
        }
    }
    var volumeUnit = Volume.liters {
        didSet {
            calculateMass()
        }
    }
    var massUnit = Mass.kilograms {
        didSet {
            calculateMass()
        }
    }
    
    init() {
        setDensity()
    }
    
    mutating func calculateMass() {
        var volumeMultiplier: Double = 0
        var massMultiplier: Double = 0
        if fuelTypeUnit == .poundsPerUSGallon {
            volumeMultiplier = Volume.gallonsUS.convert(value: 1, to: volumeUnit)
            massMultiplier = Mass.pounds.convert(value: 1, to: massUnit)
        } else {
            volumeMultiplier = Volume.liters.convert(value: 1, to: volumeUnit)
            massMultiplier = Mass.kilograms.convert(value: 1, to: massUnit)
        }
        self.mass = volume * ( density * massMultiplier/volumeMultiplier )
    }
    
    mutating func setDensity() {
        if fuelTypeUnit == .poundsPerUSGallon {
            density = fuelType.densityPoundsPerGallon
        } else {
            density = fuelType.densityKilogramPerLiter
        }
    }
}
