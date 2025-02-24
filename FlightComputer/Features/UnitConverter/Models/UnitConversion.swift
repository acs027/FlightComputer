//
//  UnitConversion.swift
//  FlightComputer
//
//  Created by ali cihan on 13.02.2025.
//

import Foundation

struct UnitConversion {
    var areaValue: Double = 0
    var areaUnit: Area = .squareMiles
    var toAreaUnit: Area = .squareFeet
    
    var distanceValue: Double = 0
    var distanceUnit: Distance = .nauticalMiles
    var toDistanceUnit: Distance = .statuteMiles
    
    var massValue: Double = 0
    var massUnit: Mass = .kilograms
    var toMassUnit: Mass = .grams
    
    var pressureValue: Double = 0
    var pressureUnit: Pressure = .inchesOfMercury
    var toPressureUnit: Pressure = .millimetersOfMercury
    
    var temperatureValue: Double = 0
    var temperatureUnit: Temperature = .celsius
    var toTemperatureUnit: Temperature = .kelvin
    
    var volumeValue: Double = 0
    var volumeUnit: Volume = .liters
    var toVolumeUnit: Volume = .gallonsUS
    
    mutating func swapUnits(for type: ConversionType) {
        switch type {
        case .distance:
            let distanceUnit = distanceUnit
            self.distanceUnit =  self.toDistanceUnit
            self.toDistanceUnit = distanceUnit
        case .mass:
            let massUnit = massUnit
            self.massUnit = self.toMassUnit
            self.toMassUnit = massUnit
        case .volume:
            let volumeUnit = volumeUnit
            self.volumeUnit = self.toVolumeUnit
            self.toVolumeUnit = volumeUnit
        case .temperature:
            let temperatureUnit = temperatureUnit
            self.temperatureUnit = self.toTemperatureUnit
            self.toTemperatureUnit = temperatureUnit
        case .pressure:
            let pressureUnit = pressureUnit
            self.pressureUnit = self.toPressureUnit
            self.toPressureUnit = pressureUnit
        case .area:
            let areaUnit = areaUnit
            self.areaUnit = self.toAreaUnit
            self.toAreaUnit = areaUnit
        }
    }
}

enum ConversionType: String, CaseIterable {
    case distance = "Distance"
    case mass = "Mass"
    case volume = "Volume"
    case temperature = "Temperature"
    case pressure = "Pressure"
    case area = "Area"
    
    var systemImage: String {
        switch self {
        case .distance:
            "ruler.fill"
        case .mass:
            "scalemass.fill"
        case .volume:
            "drop.fill"
        case .temperature:
            "thermometer.transmission"
        case .pressure:
            "tirepressure"
        case .area:
            "rectangle.pattern.checkered"
        }
    }
}

protocol UnitType: Hashable {
    func convert(value: Double, to unit: Self) -> Double
    var symbol: String { get }
}
