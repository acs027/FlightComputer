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
    
    enum Calculator: String, CaseIterable {
        case altimeter = "With altimeter"
        case pressure = "With pressure"
    }
    
}


