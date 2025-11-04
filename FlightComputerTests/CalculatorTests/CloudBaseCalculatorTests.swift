//
//  File.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import XCTest
@testable import FlightComputer

class CloudBaseCalculatorTests: XCTestCase {

    func testCloudBaseCalculation() {
        var calculator = CloudBaseCalculator()
        calculator.stationAltitudeUnit = .meters
        calculator.ambientDewpointUnit = .celsius
        calculator.ambientTempUnit = .celsius
        
        calculator.ambientTemp = 20
        calculator.ambientDewpoint = 10
        calculator.stationAltitude = 100
        
        let expectedCloudBase: Double = 1347
        XCTAssertEqual(calculator.cloudBaseAltitude, expectedCloudBase, "Cloud base altitude should be 1350m")
    }

    func testZeroTemperatureSpread() {
        var calculator = CloudBaseCalculator()
        calculator.stationAltitudeUnit = .meters
        calculator.ambientDewpointUnit = .celsius
        calculator.ambientTempUnit = .celsius
        
        calculator.ambientTemp = 15
        calculator.ambientDewpoint = 15
        calculator.stationAltitude = 500

        XCTAssertEqual(calculator.cloudBaseAltitude, 500, "Cloud base should be at station altitude (500m)")
    }

    func testNegativeTemperatureSpread() {
        var calculator = CloudBaseCalculator()
        calculator.stationAltitudeUnit = .meters
        calculator.ambientDewpointUnit = .celsius
        calculator.ambientTempUnit = .celsius
        
        calculator.ambientTemp = 10
        calculator.ambientDewpoint = 12
        calculator.stationAltitude = 200

        XCTAssertTrue(calculator.cloudBaseAltitude <= 200, "Cloud base should not be above station altitude when temp spread is negative")
    }

    func testExtremeTemperatureValues() {
        var calculator = CloudBaseCalculator()
        calculator.stationAltitudeUnit = .meters
        calculator.ambientDewpointUnit = .celsius
        calculator.ambientTempUnit = .celsius
        
        calculator.ambientTemp = 50
        calculator.ambientDewpoint = -10
        calculator.stationAltitude = 300

        let expectedCloudBase: Double = 7781  // 300 + 7500 = 7800m
        XCTAssertEqual(calculator.cloudBaseAltitude, expectedCloudBase, accuracy: 1, "Cloud base should be at 7800m")
    }
}

