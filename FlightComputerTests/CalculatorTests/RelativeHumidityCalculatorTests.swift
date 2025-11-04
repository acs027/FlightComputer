//
//  RelativeHumidityCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import XCTest
@testable import FlightComputer

class RelativeHumidityCalculatorTests: XCTestCase {

    func testRelativeHumidityAt100Percent() {
        let calculator = RelativeHumidityCalculator(airTemp: 20, dewpoint: 20)

        // When air temperature equals the dewpoint, RH should be 100%
        let expectedRH = 100.0

        XCTAssertTrue(abs(calculator.relativeHumidity - expectedRH) < 0.1, "Relative humidity should be 100% when temp equals dewpoint")
    }

    func testRelativeHumidityAt0Percent() {
        let calculator = RelativeHumidityCalculator(airTemp: 30, dewpoint: -50)

        // Extremely low dewpoint should result in near 0% RH
        let expectedRH = 0.0

        XCTAssertTrue(calculator.relativeHumidity < 1, "Relative humidity should be near 0% for extreme temperature differences")
    }

    func testRelativeHumidityAt50Percent() {
        let calculator = RelativeHumidityCalculator(airTemp: 30, dewpoint: 18)

        // Approximate known RH value for airTemp = 30°C, dewpoint = 18°C
        let expectedRH = 49.0

        XCTAssertTrue(abs(calculator.relativeHumidity - expectedRH) < 1.0, "Relative humidity should be around 50% for airTemp 30°C and dewpoint 18°C")
    }

    func testRelativeHumidityAtDewpoint10DegreesLower() {
        let calculator = RelativeHumidityCalculator(airTemp: 25, dewpoint: 15)

        // RH should be around 52% based on approximation
        let expectedRH = 52.0

        XCTAssertTrue(abs(calculator.relativeHumidity - expectedRH) < 2.0, "Relative humidity should be around 52% for airTemp 25°C and dewpoint 15°C")
    }
}
