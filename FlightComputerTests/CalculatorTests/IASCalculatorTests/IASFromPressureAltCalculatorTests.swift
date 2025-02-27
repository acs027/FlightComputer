//
//  IASFromPressureAltCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import Foundation
import Testing
@testable import FlightComputer

struct IASFromPressureAltCalculatorTests {

    // Test case 1: Standard conditions at sea level
    @Test func testIASAtSeaLevel() {
        let calculator = IASFromPressureAltCalculator(
            pressureAltitude: 0, // Sea level in feet
            outsideAirTemp: 15,  // Standard temperature at sea level in °C
            trueAirSpeed: 100    // TAS in knots
        )
        let ias = calculator.indicatedAirSpeed
        #expect(ias == 100, "IAS should equal TAS at sea level under standard conditions.")
    }

    // Test case 2: High altitude with standard temperature
    @Test func testIASAtHighAltitude() {
        let calculator = IASFromPressureAltCalculator(
            pressureAltitude: 30000, // 30,000 feet
            outsideAirTemp: -44.4,   // Standard temperature at 30,000 feet in °C
            trueAirSpeed: 250        // TAS in knots
        )
        let ias = calculator.indicatedAirSpeed
        #expect(ias > 150 && ias < 160, "IAS should be significantly lower than TAS at high altitude.")
    }

    // Test case 3: Edge case - very high altitude and low temperature
    @Test func testIASAtVeryHighAltitude() {
        let calculator = IASFromPressureAltCalculator(
            pressureAltitude: 50000, // 50,000 feet
            outsideAirTemp: -56.5,   // Standard temperature at 50,000 feet in °C
            trueAirSpeed: 300       // TAS in knots
        )
        let ias = calculator.indicatedAirSpeed
        #expect(ias > 100 && ias < 120, "IAS should be much lower than TAS at very high altitude.")
    }

    // Test case 4: Edge case - negative altitude (below sea level)
    @Test func testIASBelowSeaLevel() {
        let calculator = IASFromPressureAltCalculator(
            pressureAltitude: -1000, // -1,000 feet (below sea level)
            outsideAirTemp: 20,     // OAT in °C
            trueAirSpeed: 150        // TAS in knots
        )
        let ias = calculator.indicatedAirSpeed
        #expect(ias > 150 && ias < 160, "IAS should be slightly higher than TAS below sea level.")
    }

    // Test case 5: Edge case - extreme temperature
    @Test func testIASAtExtremeTemperature() {
        let calculator = IASFromPressureAltCalculator(
            pressureAltitude: 10000, // 10,000 feet
            outsideAirTemp: -60,     // Extreme cold temperature in °C
            trueAirSpeed: 200        // TAS in knots
        )
        let ias = calculator.indicatedAirSpeed
        #expect(ias > 120 && ias < 140, "IAS should be lower than TAS at extreme cold temperatures.")
    }
}
