//
//  SpeedOfSoundCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import Foundation
import Testing
@testable import FlightComputer

struct SpeedOfSoundCalculatorTests {

    @Test func speedOfSoundAtSeaLevel() async throws {
        let calculator = SpeedOfSoundCalculator(altitude: 0, standardTemperature: 15, selectedUnit: .metersPerSecond)

        let expectedSpeed = 340.29 // Speed of sound at sea level in m/s

        #expect(abs(calculator.calculatedSpeed - expectedSpeed) < 1.0, "Speed of sound should be 340.29 m/s at sea level with 15°C")
    }

    @Test func speedOfSoundAt10000Feet() async throws {
        let calculator = SpeedOfSoundCalculator(altitude: 10000 * 0.3048, standardTemperature: -5, selectedUnit: .metersPerSecond)

        let expectedSpeed = 320.5 // Approximate value in m/s

        #expect(abs(calculator.calculatedSpeed - expectedSpeed) < 1.5, "Speed of sound should be around 320.5 m/s at 10,000 feet with -5°C")
    }

    @Test func speedOfSoundInKnots() async throws {
        let calculator = SpeedOfSoundCalculator(altitude: 0, standardTemperature: 15, selectedUnit: .knots)

        let expectedSpeed = 661.5 // Approximate value in knots

        #expect(abs(calculator.calculatedSpeed - expectedSpeed) < 2.0, "Speed of sound should be around 661.5 knots at sea level with 15°C")
    }

    @Test func speedOfSoundInMPH() async throws {
        let calculator = SpeedOfSoundCalculator(altitude: 0, standardTemperature: 15, selectedUnit: .mph)

        let expectedSpeed = 761.2 // Approximate value in mph

        #expect(abs(calculator.calculatedSpeed - expectedSpeed) < 2.0, "Speed of sound should be around 761.2 mph at sea level with 15°C")
    }

    @Test func machNumberAtSeaLevel() async throws {
        let calculator = SpeedOfSoundCalculator(altitude: 0, standardTemperature: 15, selectedUnit: .metersPerSecond)

        let expectedMach = 1.0 // Mach number should be 1 when speed = speed of sound

        #expect(abs(calculator.machNumber - expectedMach) < 0.01, "Mach number should be 1.0 at sea level when speed equals speed of sound")
    }
}
