//
//  FlightComputerViewModel.swift
//  FlightComputer
//
//  Created by ali cihan on 9.02.2025.
//

import Foundation

@Observable
class FlightComputerViewModel {
    var WCACalculator = WindCorrectionAngleCalculator()
    var flightTimeCalculator = FlightTimeCalculator()
    var fuelConsumptionCalculator = FuelConsumptionCalculator()
}
