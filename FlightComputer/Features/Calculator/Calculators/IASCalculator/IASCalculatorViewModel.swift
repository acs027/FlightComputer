//
//  IASCalculatorViewModel.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import Foundation

@Observable class IASCalculatorViewModel {
    var fromAltimeterCalculator = IASFromAltimeterCalculator()
    var fromPressureAltCalculator = IASFromPressureAltCalculator()
    
    var calculator: Calculator = .altimeter
    
    enum Calculator {
        case altimeter, pressure
    }
}
