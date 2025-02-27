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
    
    var altimeterSettingUnit = Pressure.inchesOfMercury
    var fieldElevationUnit = Distance.feet

    private let pressureFactor = 1000.0  // Conversion factor (inHg → feet)

    var pressureAltitude: Double {
        let altimeterSettingInHg = altimeterSettingUnit.convert(value: altimeterSetting, to: .inchesOfMercury)
        let fieldElevationInFeet = fieldElevationUnit.convert(value: fieldElevation, to: .feet)
        let pressureAltitudeInFeet = (29.92 - altimeterSettingInHg) * pressureFactor + fieldElevationInFeet
        return Distance.feet.convert(value: pressureAltitudeInFeet, to: fieldElevationUnit)
    }
}
