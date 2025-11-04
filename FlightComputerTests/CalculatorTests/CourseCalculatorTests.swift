//
//  CourseCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//
import Foundation
import XCTest
@testable import FlightComputer

class CourseCalculatorTests: XCTestCase {

    func testHeadWindCalculation() {
        let calculator = CourseCalculator(heading: 90, trueAirSpeed: 100, windDirection: 90, windSpeed: 20)
        
        // Wind is directly from the front, so headwind should be full wind speed
        XCTAssertEqual(calculator.headWind, 20, "Headwind should be 20 knots when wind is directly head-on")
    }
    
    func testCrossWindCalculation() {
        let calculator = CourseCalculator(heading: 90, trueAirSpeed: 100, windDirection: 180, windSpeed: 20)
        
        // Wind is directly from the right (90° to heading), so full crosswind
        XCTAssertEqual(calculator.crossWind, 20, "Crosswind should be 20 knots when wind is perpendicular to heading")
    }
    
    func testWindCorrectionAngleCalculation() {
        let calculator = CourseCalculator(heading: 90, trueAirSpeed: 100, windDirection: 180, windSpeed: 20)
        
        // Crosswind exists, should require correction
        let expectedWCA = atan2(calculator.crossWind, 100) * 180 / .pi
        XCTAssertEqual(calculator.windCorrectionAngle, expectedWCA, "WCA should match arctan(crosswind / TAS)")
    }
    
    func testTrueCourseCalculation() {
        let calculator = CourseCalculator(heading: 90, trueAirSpeed: 100, windDirection: 180, windSpeed: 20)
        
        XCTAssertEqual(calculator.trueCourse, 79, accuracy: 1, "True Course should be heading + WCA")
    }
    
    func testGroundSpeedCalculation() {
        let calculator = CourseCalculator(heading: 90, trueAirSpeed: 100, windDirection: 90, windSpeed: 20)
        
        // Headwind should reduce ground speed
        let expectedGS = sqrt(pow(100 - calculator.headWind, 2) + pow(calculator.crossWind, 2))
        XCTAssertEqual(calculator.groundSpeed, expectedGS, "Ground Speed should match calculated formula")
    }
}

