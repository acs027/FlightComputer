//
//  PressureAltitudeCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import Foundation
import Testing
@testable import FlightComputer

struct PressureAltitudeCalculatorTests {

    @Test func standardPressureAltitude() async throws {
        let calculator = PressureAltitudeCalculator(altimeterSetting: 29.92, fieldElevation: 500)

        // Standard pressure altitude should equal field elevation
        let expectedAltitude = 500.0

        #expect(calculator.pressureAltitude == expectedAltitude, "Incorrect pressure altitude at standard pressure")
    }

    @Test func lowPressureAltitude() async throws {
        let calculator = PressureAltitudeCalculator(altimeterSetting: 29.42, fieldElevation: 500)

        // Pressure altitude calculation: (29.92 - 29.42) * 1000 + 500
        let expectedAltitude = (29.92 - 29.42) * 1000 + 500  // 1000 feet increase

        #expect(calculator.pressureAltitude == expectedAltitude, "Incorrect pressure altitude at low pressure")
    }

    @Test func highPressureAltitude() async throws {
        let calculator = PressureAltitudeCalculator(altimeterSetting: 30.42, fieldElevation: 500)

        // Pressure altitude calculation: (29.92 - 30.42) * 1000 + 500
        let expectedAltitude = (29.92 - 30.42) * 1000 + 500  // 1000 feet decrease

        #expect(calculator.pressureAltitude == expectedAltitude, "Incorrect pressure altitude at high pressure")
    }

    @Test func seaLevelFieldElevation() async throws {
        let calculator = PressureAltitudeCalculator(altimeterSetting: 29.92, fieldElevation: 0)

        // At sea level with standard pressure, pressure altitude should be 0
        let expectedAltitude = 0.0

        #expect(calculator.pressureAltitude == expectedAltitude, "Incorrect pressure altitude at sea level")
    }

    @Test func highFieldElevation() async throws {
        let calculator = PressureAltitudeCalculator(altimeterSetting: 29.92, fieldElevation: 5000)

        // Field elevation is 5000 feet at standard pressure
        let expectedAltitude = 5000.0

        #expect(calculator.pressureAltitude == expectedAltitude, "Incorrect pressure altitude at high field elevation")
    }
}
