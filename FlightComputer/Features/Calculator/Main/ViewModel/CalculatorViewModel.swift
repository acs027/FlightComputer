//
//  CalculatorViewModel.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import Foundation

@Observable class CalculatorViewModel {
}

enum Calculator: CaseIterable {
    case cloudBase, course, densityAltitude, dewpoint, ias, machSpeed, pressureAltitude, relativeHumidity, speedOfSound, tas, windComponent, windDirectionSpeed
    
    var description: String {
        switch self {
        case .cloudBase:
            return "Cloud Base"
        case .course:
            return "Course"
        case .densityAltitude:
            return "Density Altitude"
        case .dewpoint:
            return "Dewpoint"
        case .ias:
            return "IAS"
        case .machSpeed:
            return "Mach Speed"
        case .pressureAltitude:
            return "Pressure Altitude"
        case .relativeHumidity:
            return "Relative Humidity"
        case .speedOfSound:
            return "Speed of Sound"
        case .tas:
            return "TAS"
        case .windComponent:
            return "Wind Component"
        case .windDirectionSpeed:
            return "Wind Direction & Speed"
        }
    }
    
    var systemImage: String {
        switch self {
        case .cloudBase:
            return "cloud.fill"
        case .course:
            return "line.diagonal.arrow"
        case .densityAltitude:
            return "mountain.2.fill"
        case .dewpoint:
            return "drop.degreesign.fill"
        case .ias:
            return "gauge.with.dots.needle.33percent"
        case .machSpeed:
            return "airplane"
        case .pressureAltitude:
            return "barometer"
        case .relativeHumidity:
            return "humidity.fill"
        case .speedOfSound:
            return "waveform.path.ecg"
        case .tas:
            return "speedometer"
        case .windComponent:
            return "arrow.up.left.and.down.right.magnifyingglass"
        case .windDirectionSpeed:
            return "wind"
        }
    }
}
