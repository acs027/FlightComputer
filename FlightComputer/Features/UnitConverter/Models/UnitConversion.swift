//
//  UnitConversion.swift
//  FlightComputer
//
//  Created by ali cihan on 13.02.2025.
//

import Foundation

struct UnitConversion {
    var areaValue: Double = 0
    var areaUnit: Area = .squareMeters
    
    var distanceValue: Double = 0
    var distanceUnit: Distance = .meters
    
    var massValue: Double = 0
    var massUnit: Mass = .kilograms
    
    var pressureValue: Double = 0
    var pressureUnit: Pressure = .pascals
    
    var temperatureValue: Double = 0
    var temperatureUnit: Temperature = .celsius
    
    var volumeValue: Double = 0
    var volumeUnit: Volume = .liters
}

enum ConversionType: String, CaseIterable {
    case area = "Area"
    case distance = "Distance"
    case mass = "Mass"
    case pressure = "Pressure"
    case temperature = "Temperature"
    case volume = "Volume"
}

protocol UnitType: Hashable {
    func convert(value: Double, to unit: Self) -> Double
    var symbol: String { get }
}
