//
//  FuelConsumptionCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 12.02.2025.
//

import Foundation

struct FuelConsumptionCalculator {
    var flightTime: Double?
    var fuelPerHour: Double?
    var requiredFuel: Double? {
        guard let flightTime = flightTime,
              let fuelPerHour = fuelPerHour else { return nil }
        return (flightTime / 60) * fuelPerHour
    }
    
}
