//
//  MachSpeedCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import XCTest
@testable import FlightComputer

class MachSpeedCalculatorTests: XCTestCase {

    func testMachNumberCalculation() {
        let calculator = MachSpeedCalculator(altitude: 5000, standardTemperature: 15, speed: 340)

        XCTAssertEqual(calculator.machNumber, 1, accuracy: 0.01, "Incorrect Mach Number Calculation")
    }

    func testSpeedCalculationInKnots() {
        let calculator = MachSpeedCalculator(altitude: 5000, standardTemperature: 15, machSpeedUnit: .knots)

        XCTAssertEqual(calculator.speedOfSoundAtAltitude, 661, accuracy: 1, "Incorrect Speed Calculation in Knots")
    }

    func testSpeedCalculationInKmh() {
        let calculator = MachSpeedCalculator(altitude: 5000, standardTemperature: 15, machSpeedUnit: .kilometersPerHour)


        XCTAssertEqual(calculator.speedOfSoundAtAltitude, 1225, accuracy: 1, "Incorrect Speed Calculation in KM/H")
    }
}

