//
//  DensityAltitudeCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import XCTest
@testable import FlightComputer

class DensityAltitudeCalculatorTests: XCTestCase {

    func testIsaTemperatureCalculation() {
        let calculator = DensityAltitudeCalculator(pressureAltitude: 5000, oat: 0, pressureAltitudeUnit: .meters, oatUnit: .celsius)
        
        let expectedISATemp: Double = 15
        let expedtedDensityAltitude: Double = 4456
        XCTAssertEqual(calculator.isaTemp, expectedISATemp, accuracy: 1, "ISA Temperature at 5000 m should be 15°C")
        XCTAssertEqual(calculator.densityAltitude, expedtedDensityAltitude, accuracy: 1, "Density altitude at 5000 m 0 OAT C should be 4456 m")
    }

    func testDensityAltitudeCalculation() {
        var calculator = DensityAltitudeCalculator(pressureAltitude: 5000, oat: 20, pressureAltitudeUnit: .meters, oatUnit: .celsius)
        
        let expectedDA: Double = 5181
        XCTAssertEqual(calculator.densityAltitude, expectedDA, accuracy: 1, "Density altitude should match calculated value")
    }

    func testSeaLevelDensityAltitude() {
        let calculator = DensityAltitudeCalculator(pressureAltitude: 0, oat: 15, oatUnit: .celsius)
        
        // At sea level, ISA Temp = 15°C, OAT = 15°C → DA should be 0
        XCTAssertEqual(calculator.densityAltitude, 0, "Density altitude at sea level and ISA conditions should be 0")
    }

    func testHighTemperatureEffect() {
        let calculator = DensityAltitudeCalculator(pressureAltitude: 3000, oat: 40, pressureAltitudeUnit: .feet)
        
        // Hot day at 3000 ft should result in a significantly higher density altitude
        XCTAssertTrue(calculator.densityAltitude > 5000, "High temperature should increase density altitude above 5000 ft")
    }

    func testLowTemperatureEffect() {
        let calculator = DensityAltitudeCalculator(pressureAltitude: 3000, oat: -20)
        
        // Cold day at 3000 ft should lower density altitude
        _ = 3000 + 120 * (-20 - calculator.isaTemp)
        XCTAssertTrue(calculator.densityAltitude < 3000, "Low temperature should decrease density altitude below pressure altitude")
    }
}

