//
//  FuelMassCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 2.02.2026.
//

import Foundation


@Observable
class FuelMassCalculatorViewModel {
    var fuelMassCalculator = FuelMassCalculator()
    var fuelTypeUnits: [Density] = [.kilogramPerLiter, .poundsPerUSGallon]
}
