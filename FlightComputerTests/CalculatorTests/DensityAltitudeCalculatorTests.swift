//
//  DensityAltitudeCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import Testing
@testable import FlightComputer

struct DensityAltitudeCalculatorTests {

    @Test func isaTemperatureCalculation() async throws {
        let calculator = DensityAltitudeCalculator(pressureAltitude: 5000, oat: 0)
        
        // ISA Temp at 5000 ft: 15 + (-1.98 * 5) = 5.1°C
        let expectedISATemp = 15.0 + (-1.98 / 1000 * 5000)
        #expect(calculator.isaTemp == expectedISATemp, "ISA Temperature at 5000 ft should be 5.1°C")
    }

    @Test func densityAltitudeCalculation() async throws {
        let calculator = DensityAltitudeCalculator(pressureAltitude: 5000, oat: 20)
        
        // Density Altitude: 5000 + 120 * (20 - ISA Temp)
        let expectedDA = 5000 + 120 * (20 - calculator.isaTemp)
        #expect(calculator.densityAltitude == expectedDA, "Density altitude should match calculated value")
    }

    @Test func seaLevelDensityAltitude() async throws {
        let calculator = DensityAltitudeCalculator(pressureAltitude: 0, oat: 15)
        
        // At sea level, ISA Temp = 15°C, OAT = 15°C → DA should be 0
        #expect(calculator.densityAltitude == 0, "Density altitude at sea level and ISA conditions should be 0")
    }

    @Test func highTemperatureEffect() async throws {
        let calculator = DensityAltitudeCalculator(pressureAltitude: 3000, oat: 40)
        
        // Hot day at 3000 ft should result in a significantly higher density altitude
        _ = 3000 + 120 * (40 - calculator.isaTemp)
        #expect(calculator.densityAltitude > 5000, "High temperature should increase density altitude above 5000 ft")
    }

    @Test func lowTemperatureEffect() async throws {
        let calculator = DensityAltitudeCalculator(pressureAltitude: 3000, oat: -20)
        
        // Cold day at 3000 ft should lower density altitude
        _ = 3000 + 120 * (-20 - calculator.isaTemp)
        #expect(calculator.densityAltitude < 3000, "Low temperature should decrease density altitude below pressure altitude")
    }
}

