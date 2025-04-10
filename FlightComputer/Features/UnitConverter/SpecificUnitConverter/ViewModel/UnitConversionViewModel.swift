//
//  UnitConversionViewModel.swift
//  FlightComputer
//
//  Created by ali cihan on 13.02.2025.
//

import Foundation
import Observation

@Observable
class UnitConversionViewModel {
    var unitConversion = UnitConversion()
    var selectedConversion: ConversionType = .distance {
        didSet {
            numPadInput = ""
        }
    }
    var isConversionViewShowing = false
    var numPadInput = ""
    
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
            case .speed:
                unitConversion.speedValue
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
            case .speed:
                unitConversion.speedValue = newValue
            }
        }
        
    }
    
    func swapUnits() {
        unitConversion.swapUnits(for: selectedConversion)
    }
}
