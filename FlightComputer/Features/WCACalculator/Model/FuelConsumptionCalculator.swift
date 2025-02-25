//
//  FuelConsumptionCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 12.02.2025.
//

import Foundation

struct FuelConsumptionCalculator {
    var flightTime: Double = 0
    var fuelPerHour: Double = 0
    var requiredFuel: Double {
        return (flightTime / 60) * fuelPerHour
    }
    
}
