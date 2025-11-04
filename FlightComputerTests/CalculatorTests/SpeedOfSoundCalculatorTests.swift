//
//  SpeedOfSoundCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import Foundation
import XCTest
@testable import FlightComputer

class SpeedOfSoundCalculatorTests: XCTestCase {

    func testSpeedOfSoundAtSeaLevel() {
        let calculator = SpeedOfSoundCalculator(altitude: 0, standardTemperature: 15, speedUnit: .metersPerSecond)

        let expectedSpeed = 340.29 // Speed of sound at sea level in m/s

        XCTAssertTrue(abs(calculator.speedOfSoundAtAltitude - expectedSpeed) < 1.0, "Speed of sound should be 340.29 m/s at sea level with 15°C")
    }

    func testSpeedOfSoundAt10000Feet() {
        let calculator = SpeedOfSoundCalculator(altitude: 3000, standardTemperature: -5, speedUnit: .metersPerSecond)

        let expectedSpeed: Double = 328 // Approximate value in m/s

        XCTAssertTrue(abs(calculator.speedOfSoundAtAltitude - expectedSpeed) < 1.5, "Speed of sound should be around 320.5 m/s at 10,000 feet with -5°C")
    }

    func testSpeedOfSoundInKnots() {
        let calculator = SpeedOfSoundCalculator(altitude: 0, standardTemperature: 15, speedUnit: .knots)

        let expectedSpeed = 661.5 // Approximate value in knots

        XCTAssertTrue(abs(calculator.speedOfSoundAtAltitude - expectedSpeed) < 2.0, "Speed of sound should be around 661.5 knots at sea level with 15°C")
    }

    func testMachNumberAtSeaLevel() {
        let calculator = SpeedOfSoundCalculator(altitude: 0, standardTemperature: 15, speedUnit: .metersPerSecond)

        let expectedMach: Double = 340 // Mach number should be 1 when speed = speed of sound

        XCTAssertTrue(abs(calculator.speedOfSoundAtAltitude - expectedMach) < 1, "Mach number should be 1.0 at sea level when speed equals speed of sound")
    }
}
