//
//  WCACalculationSteps.swift
//  FlightComputer
//
//  Created by ali cihan on 17.02.2025.
//

import Foundation

enum WCACalculationSteps: String {
    case windDirection = "Place Wind Direction under True Index"
    case windVelocity = "Mark Wind Velocity up from the center point"
    case trueCourse = "Place True Course under True Index."
    case trueAirSpeed = "Slide Wind Velocity Mark to True Air Speed."
    case result = "Result"
    
    mutating func next() {
        switch self {
        case .windDirection:
            self = .windVelocity
        case .windVelocity:
            self = .trueCourse
        case .trueCourse:
            self = .trueAirSpeed
        case .trueAirSpeed:
            self = .result
        case .result:
            self = .windDirection
        }
    }
    
    mutating func back() {
        switch self {
        case .windDirection:
            self = .windDirection
        case .windVelocity:
            self = .windDirection
        case .trueCourse:
            self = .windVelocity
        case .trueAirSpeed:
            self = .trueCourse
        case .result:
            self = .trueAirSpeed
        }
    }
}
