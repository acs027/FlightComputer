//
//  WindComponentCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import Foundation
import XCTest
@testable import FlightComputer

class WindComponentCalculatorTests: XCTestCase {

    func testHeadWindCalculation() {
        let calculator = WindComponentCalculator(windSpeed: 20, windDirection: 90, runwayHeading: 90)

        let expectedHeadWind = 20.0 // Wind directly on the nose, so headwind should be equal to wind speed

        XCTAssertTrue(abs(calculator.headWind - expectedHeadWind) < 0.1, "Headwind should be 20.0 knots when wind direction is 90° and runway is 90°")
    }

    func testTailWindCalculation() {
        let calculator = WindComponentCalculator(windSpeed: 20, windDirection: 270, runwayHeading: 90)

        let expectedTailWind = -20.0 // Wind directly opposite to the runway, so tailwind should be negative and equal to wind speed

        XCTAssertTrue(abs(calculator.headWind - expectedTailWind) < 0.1, "Tailwind should be -20.0 knots when wind direction is 270° and runway is 90°")
    }

    func testCrossWindCalculationLeft() {
        let calculator = WindComponentCalculator(windSpeed: 20, windDirection: 0, runwayHeading: 90)

        let expectedCrossWind = -20.0 // Wind coming from left of the runway, so crosswind should be negative and equal to wind speed

        XCTAssertTrue(abs(calculator.crossWind - expectedCrossWind) < 0.1, "Crosswind should be -20.0 knots when wind direction is 0° and runway is 90°")
    }

    func testCrossWindCalculationRight() {
        let calculator = WindComponentCalculator(windSpeed: 20, windDirection: 180, runwayHeading: 90)

        let expectedCrossWind = 20.0 // Wind coming from right of the runway, so crosswind should be positive and equal to wind speed

        XCTAssertTrue(abs(calculator.crossWind - expectedCrossWind) < 0.1, "Crosswind should be 20.0 knots when wind direction is 180° and runway is 90°")
    }

    func testWindAngleCalculation() {
        let calculator = WindComponentCalculator(windSpeed: 20, windDirection: 180, runwayHeading: 90)

        let expectedWindAngle = 90.0 * .pi / 180 // Wind is coming from 180°, runway is at 90°; so angle between them should be 90°

        XCTAssertTrue(abs(calculator.windAngle - expectedWindAngle) < 0.1, "Wind angle should be 90° in radians")
    }
}
