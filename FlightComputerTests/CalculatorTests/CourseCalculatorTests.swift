//
//  CourseCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//
import Foundation
import Testing
@testable import FlightComputer

struct CourseCalculatorTests {

    @Test func headWindCalculation() async throws {
        let calculator = CourseCalculator(heading: 90, trueAirSpeed: 100, windDirection: 90, windSpeed: 20)
        
        // Wind is directly from the front, so headwind should be full wind speed
        #expect(calculator.headWind == 20, "Headwind should be 20 knots when wind is directly head-on")
    }
    
    @Test func crossWindCalculation() async throws {
        let calculator = CourseCalculator(heading: 90, trueAirSpeed: 100, windDirection: 180, windSpeed: 20)
        
        // Wind is directly from the right (90° to heading), so full crosswind
        #expect(calculator.crossWind == 20, "Crosswind should be 20 knots when wind is perpendicular to heading")
    }
    
    @Test func windCorrectionAngleCalculation() async throws {
        let calculator = CourseCalculator(heading: 90, trueAirSpeed: 100, windDirection: 180, windSpeed: 20)
        
        // Crosswind exists, should require correction
        let expectedWCA = atan2(calculator.crossWind, 100) * 180 / .pi
        #expect(calculator.windCorrectionAngle == expectedWCA, "WCA should match arctan(crosswind / TAS)")
    }
    
    @Test func trueCourseCalculation() async throws {
        let calculator = CourseCalculator(heading: 90, trueAirSpeed: 100, windDirection: 180, windSpeed: 20)
        
        let expectedTrueCourse = 90 + calculator.windCorrectionAngle
        #expect(calculator.trueCourse == expectedTrueCourse, "True Course should be heading + WCA")
    }
    
    @Test func groundSpeedCalculation() async throws {
        let calculator = CourseCalculator(heading: 90, trueAirSpeed: 100, windDirection: 90, windSpeed: 20)
        
        // Headwind should reduce ground speed
        let expectedGS = sqrt(pow(100 - calculator.headWind, 2) + pow(calculator.crossWind, 2))
        #expect(calculator.groundSpeed == expectedGS, "Ground Speed should match calculated formula")
    }
}

