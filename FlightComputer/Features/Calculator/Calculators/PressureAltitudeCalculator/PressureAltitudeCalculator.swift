//
//  PressureAltitudeCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import Foundation

struct PressureAltitudeCalculator {
    var altimeterSetting: Double = 29.92  // inHg (Default: ISA standard)
    var fieldElevation: Double = 0  // in feet

    private let pressureFactor = 1000.0  // Conversion factor (inHg → feet)

    var pressureAltitude: Double {
        (29.92 - altimeterSetting) * pressureFactor + fieldElevation
    }
}
