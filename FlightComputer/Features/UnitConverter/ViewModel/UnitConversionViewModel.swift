//
//  UnitConversionViewModel.swift
//  FlightComputer
//
//  Created by ali cihan on 13.02.2025.
//

import Foundation

@Observable class UnitConversionViewModel {
    var unitConversion = UnitConversion()
    var selectedConversion: ConversionType = .distance
    var isConversionViewShowing = false
    
    var value: Double {
        get {
            switch selectedConversion {
            case .area:
                unitConversion.areaValue
            case .distance:
                unitConversion.distanceValue
            case .mass:
                unitConversion.massValue
            case .pressure:
                unitConversion.pressureValue
            case .temperature:
                unitConversion.temperatureValue
            case .volume:
                unitConversion.volumeValue
            }
        }
        set(newValue) {
            switch selectedConversion {
            case .area:
                unitConversion.areaValue = newValue
            case .distance:
                unitConversion.distanceValue = newValue
            case .mass:
                unitConversion.massValue = newValue
            case .pressure:
                unitConversion.pressureValue = newValue
            case .temperature:
                unitConversion.temperatureValue = newValue
            case .volume:
                unitConversion.volumeValue = newValue
            }
        }
        
    }
    
    func swapUnits() {
        unitConversion.swapUnits(for: selectedConversion)
    }
}
