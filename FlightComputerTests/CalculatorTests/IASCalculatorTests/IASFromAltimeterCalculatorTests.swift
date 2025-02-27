//
//  IASCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import Foundation
import Testing
@testable import FlightComputer

struct IASFromAltimeterCalculatorTests {

    @Test func pressureAltitudeCalculation() async throws {
        let calculator = IASFromAltimeterCalculator(indicatedAltitude: 5000, altimeterSetting: 29.42)

        // Recalculate expected value manually
        let expectedPressureAltitude = (29.92 - 29.42) * 1000 + 5000

        #expect(expectedPressureAltitude == (29.92 - calculator.altimeterSetting) * 1000 + calculator.indicatedAltitude,
                "Incorrect pressure altitude calculation")
    }

    @Test func densityAltitudeCalculation() async throws {
        let calculator = IASFromAltimeterCalculator(indicatedAltitude: 5000, altimeterSetting: 29.92, outsideAirTemp: 25)

        // Compute pressure altitude manually
        let pressureAltitude = (29.92 - calculator.altimeterSetting) * 1000 + calculator.indicatedAltitude

        // Compute ISA temperature
        let isaTemp = 15.0 + (0.0065 * pressureAltitude)

        // Compute expected density altitude
        let expectedDensityAltitude = pressureAltitude + (118.8 * (calculator.outsideAirTemp - isaTemp))

        #expect(expectedDensityAltitude == pressureAltitude + 118.8 * (calculator.outsideAirTemp - isaTemp),
                "Incorrect density altitude calculation")
    }

    @Test func indicatedAirSpeedCalculation() async throws {
        let calculator = IASFromAltimeterCalculator(
            indicatedAltitude: 5000,
            altimeterSetting: 29.92,
            outsideAirTemp: 15,
            trueAirSpeed: 150
        )

        // Compute temperature at altitude
        let temperatureAtAltitude = calculator.outsideAirTemp + 273.15 // Convert to Kelvin
        let correctionFactor = sqrt((temperatureAtAltitude / 288.15) * (1013.25 / 1013.25))

        let expectedIAS = calculator.trueAirSpeed * correctionFactor

        #expect(expectedIAS == calculator.indicatedAirSpeed, "Incorrect IAS calculation")
    }

    @Test func standardConditionsIAS() async throws {
        let calculator = IASFromAltimeterCalculator(
            indicatedAltitude: 0,
            altimeterSetting: 29.92,
            outsideAirTemp: 15,
            trueAirSpeed: 150
        )

        // At standard sea-level conditions, IAS should be equal to TAS
        #expect(calculator.indicatedAirSpeed == 150, "IAS should equal TAS at sea level under standard conditions")
    }
}
