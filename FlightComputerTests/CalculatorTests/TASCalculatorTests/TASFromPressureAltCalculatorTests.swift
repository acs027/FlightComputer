//
//  TASFromPressureAltCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import Foundation
import XCTest
@testable import FlightComputer

class TASFromPressureAltCalculatorTests: XCTestCase {

    func testTrueAirSpeedCalculation() {
        let calculator = TASFromPressureAltCalculator(pressureAltitude: 5000, outsideAirTemp: 15, indicatedAirSpeed: 100)

        let expectedTAS: Double = 109 // Approximate true airspeed for these inputs

        XCTAssertTrue(abs(calculator.trueAirSpeed - expectedTAS) < 5.0, "True Airspeed should be approximately 120.0 knots at 5000 meters with 15°C outside air temp and 100 knots IAS")
    }

    func testTrueAirSpeedAtSeaLevel() {
        let calculator = TASFromPressureAltCalculator(pressureAltitude: 0, outsideAirTemp: 15, indicatedAirSpeed: 150)

        let expectedTAS: Double = 150.0 // IAS and TAS should be the same at sea level under standard conditions

        XCTAssertTrue(abs(calculator.trueAirSpeed - expectedTAS) < 1.0, "True Airspeed should be equal to IAS (150.0 knots) at sea level with 15°C outside air temperature")
    }

    func testTrueAirSpeedWithHighAltitude() {
        let calculator = TASFromPressureAltCalculator(pressureAltitude: 15000, outsideAirTemp: -10, indicatedAirSpeed: 120)

        let expectedTAS = 150.0 // Approximate true airspeed at 15000 meters under the given conditions

        XCTAssertTrue(abs(calculator.trueAirSpeed - expectedTAS) < 5.0, "True Airspeed should be approximately 140.0 knots at 15000 meters with -10°C outside air temp")
    }
}

