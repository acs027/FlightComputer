//
//  MachSpeedCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import Testing
@testable import FlightComputer

struct MachSpeedCalculatorTests {

    @Test func machNumberCalculation() async throws {
        let calculator = MachSpeedCalculator(altitude: 5000, standardTemperature: 15)

        // Recalculate speed of sound manually
        let temperatureAtAltitude = calculator.standardTemperature + (calculator.altitude * -0.00649)
        let speedOfSoundAtAltitude = 331.3 + (0.6 * temperatureAtAltitude)

        // Calculate expected Mach number
        let expectedMachNumber = (340.29 * speedOfSoundAtAltitude) / 340.29  // machSpeed / speed of sound at sea level

        #expect(calculator.machNumber == expectedMachNumber, "Incorrect Mach Number Calculation")
    }

    @Test func speedCalculationInKnots() async throws {
        let calculator = MachSpeedCalculator(altitude: 5000, standardTemperature: 15, selectedSpeedUnit: .knots)

        // Recalculate speed of sound manually
        let temperatureAtAltitude = calculator.standardTemperature + (calculator.altitude * -0.00649)
        let speedOfSoundAtAltitude = 331.3 + (0.6 * temperatureAtAltitude)
        
        // Calculate mach speed
        let machSpeed = 340.29 * speedOfSoundAtAltitude

        // Convert mach speed to knots
        let expectedSpeedInKnots = machSpeed * 1.94384

        #expect(calculator.calculatedSpeed == expectedSpeedInKnots, "Incorrect Speed Calculation in Knots")
    }

    @Test func speedCalculationInMph() async throws {
        let calculator = MachSpeedCalculator(altitude: 5000, standardTemperature: 15, selectedSpeedUnit: .mph)

        // Recalculate speed of sound manually
        let temperatureAtAltitude = calculator.standardTemperature + (calculator.altitude * -0.00649)
        let speedOfSoundAtAltitude = 331.3 + (0.6 * temperatureAtAltitude)

        // Calculate mach speed
        let machSpeed = 340.29 * speedOfSoundAtAltitude

        // Convert mach speed to mph
        let expectedSpeedInMph = machSpeed * 2.23694

        #expect(calculator.calculatedSpeed == expectedSpeedInMph, "Incorrect Speed Calculation in MPH")
    }

    @Test func speedCalculationInKmh() async throws {
        let calculator = MachSpeedCalculator(altitude: 5000, standardTemperature: 15, selectedSpeedUnit: .kmh)

        // Recalculate speed of sound manually
        let temperatureAtAltitude = calculator.standardTemperature + (calculator.altitude * -0.00649)
        let speedOfSoundAtAltitude = 331.3 + (0.6 * temperatureAtAltitude)

        // Calculate mach speed
        let machSpeed = 340.29 * speedOfSoundAtAltitude

        // Convert mach speed to km/h
        let expectedSpeedInKmh = machSpeed * 3.6

        #expect(calculator.calculatedSpeed == expectedSpeedInKmh, "Incorrect Speed Calculation in KM/H")
    }

    @Test func speedCalculationInMetersPerSecond() async throws {
        let calculator = MachSpeedCalculator(altitude: 5000, standardTemperature: 15, selectedSpeedUnit: .metersPerSecond)

        // Recalculate speed of sound manually
        let temperatureAtAltitude = calculator.standardTemperature + (calculator.altitude * -0.00649)
        let speedOfSoundAtAltitude = 331.3 + (0.6 * temperatureAtAltitude)

        // Calculate mach speed
        let machSpeed = 340.29 * speedOfSoundAtAltitude

        // Use mach speed directly in m/s
        let expectedSpeedInMetersPerSecond = machSpeed

        #expect(calculator.calculatedSpeed == expectedSpeedInMetersPerSecond, "Incorrect Speed Calculation in M/S")
    }
}

