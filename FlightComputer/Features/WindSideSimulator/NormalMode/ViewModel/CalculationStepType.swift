//
//  CalculationStepType.swift
//  FlightComputer
//
//  Created by ali cihan on 14.03.2025.
//

import Foundation

protocol CalculationStep {
    mutating func next()
    mutating func back()
}

enum CalculationStepType: Equatable {
    case driftHeading(DriftHeadingStep)
    case driftTrack(DriftTrackStep)
    case windCalculator(WindCalculatorStep)
    
    mutating func next() {
            switch self {
            case .driftHeading(var step):
                step.next()
                self = .driftHeading(step)
            case .driftTrack(var step):
                step.next()
                self = .driftTrack(step)
            case .windCalculator(var step):
                step.next()
                self = .windCalculator(step)
            }
        }
        
        mutating func back() {
            switch self {
            case .driftHeading(var step):
                step.back()
                self = .driftHeading(step)
            case .driftTrack(var step):
                step.back()
                self = .driftTrack(step)
            case .windCalculator(var step):
                step.back()
                self = .windCalculator(step)
            }
        }
    
    mutating func reset() {
        switch self {
        case .driftHeading(_):
            self = .driftHeading(.tas)
        case .driftTrack(_):
            self = .driftTrack(.tas)
        case .windCalculator(_):
            self = .windCalculator(.tas)
        }
    }
    
    static func == (lhs: CalculationStepType, rhs: CalculationStepType) -> Bool {
            switch (lhs, rhs) {
            case (.driftHeading, .driftHeading):
                return true // All driftHeading cases are equal regardless of associated value
            case (.driftTrack, .driftTrack):
                return true // All driftTrack cases are equal regardless of associated value
            case (.windCalculator, .windCalculator):
                return true // All windCalculator cases are equal regardless of associated value
            default:
                return false // Different cases are not equal
            }
        }
}

extension CalculationStep where Self: CaseIterable & Equatable {
    mutating func next() {
        let allCases = Array(Self.allCases)
        if let index = allCases.firstIndex(of: self), index < allCases.count - 1 {
            self = allCases[index + 1]
        }
    }
    
    mutating func back() {
        let allCases = Array(Self.allCases)
        if let index = allCases.firstIndex(of: self), index > 0 {
            self = allCases[index - 1]
        }
    }
}

enum DriftHeadingStep: CalculationStep, CaseIterable {
    case tas, windDirection, windSpeed, heading, result
    
    var title: String {
        switch self {
        case .tas:
            "True Air Speed"
        case .windDirection:
            "Wind Direction"
        case .windSpeed:
            "Wind Speed"
        case .heading:
            "Heading"
        case .result:
            "Result"
        }
    }
}

enum DriftTrackStep: CalculationStep, CaseIterable {
    case tas, windDirection, windSpeed, track, correction, result
    
    var title: String {
        switch self {
        case .tas:
            "True Air Speed"
        case .windDirection:
            "Wind Direction"
        case .windSpeed:
            "Wind Speed"
        case .track:
            "True Course / Track"
        case .correction:
            "Correction"
        case .result:
            "Result"
        }
    }
}

enum WindCalculatorStep: CalculationStep, CaseIterable {
    case tas, track, heading, groundSpeed, result
    
    var title: String {
        switch self {
        case .tas:
            "True Air Speed"
        case .track:
            "True Course / Track"
        case .heading:
            "Heading"
        case .groundSpeed:
            "Ground Speed"
        case .result:
            "Result"
        }
    }
}
