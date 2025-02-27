//
//  File.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import Testing
@testable import FlightComputer

struct CloudBaseCalculatorTests {

    @Test func cloudBaseCalculation() async throws {
        var calculator = CloudBaseCalculator()
        calculator.ambientTemp = 20
        calculator.ambientDewpoint = 10
        calculator.stationAltitude = 100

        let expectedCloudBase = 100 + ((20 - 10) / 0.008)  // 100 + 1250 = 1350m
        #expect(calculator.cloudBaseAltitude == expectedCloudBase, "Cloud base altitude should be 1350m")
    }

    @Test func zeroTemperatureSpread() async throws {
        var calculator = CloudBaseCalculator()
        calculator.ambientTemp = 15
        calculator.ambientDewpoint = 15
        calculator.stationAltitude = 500

        #expect(calculator.cloudBaseAltitude == 500, "Cloud base should be at station altitude (500m)")
    }

    @Test func negativeTemperatureSpread() async throws {
        var calculator = CloudBaseCalculator()
        calculator.ambientTemp = 10
        calculator.ambientDewpoint = 12
        calculator.stationAltitude = 200

        #expect(calculator.cloudBaseAltitude <= 200, "Cloud base should not be above station altitude when temp spread is negative")
    }

    @Test func extremeTemperatureValues() async throws {
        var calculator = CloudBaseCalculator()
        calculator.ambientTemp = 50
        calculator.ambientDewpoint = -10
        calculator.stationAltitude = 300

        let expectedCloudBase = 300 + ((50 - (-10)) / 0.008)  // 300 + 7500 = 7800m
        #expect(calculator.cloudBaseAltitude == expectedCloudBase, "Cloud base should be at 7800m")
    }
}

