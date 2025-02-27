//
//  TASFromAltimeterCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import Foundation
import Testing
@testable import FlightComputer

struct TASFromAltimeterCalculatorTests {

    @Test
    func trueAirSpeedCalculation() async throws {
        let calculator = TASFromAltimeterCalculator(indicatedAltitude: 5000, altimeterSetting: 29.92, outsideAirTemp: 15, indicatedAirSpeed: 100)

        let expectedTAS = 100.0 // Expected True Airspeed based on provided inputs

        #expect(abs(calculator.trueAirSpeed - expectedTAS) < 1.0, "True Airspeed should be 100.0 knots at 5000 ft, 29.92 inHg, and 15°C outside air temperature with 100 knots IAS")
    }

    @Test
    func trueAirSpeedAtSeaLevel() async throws {
        let calculator = TASFromAltimeterCalculator(indicatedAltitude: 0, altimeterSetting: 29.92, outsideAirTemp: 15, indicatedAirSpeed: 150)

        let expectedTAS = 150.0 // At sea level, IAS and TAS should be the same under standard conditions

        #expect(abs(calculator.trueAirSpeed - expectedTAS) < 1.0, "True Airspeed should be equal to IAS (150.0 knots) at sea level with 15°C outside air temperature")
    }

    @Test
    func trueAirSpeedWithHighAltitude() async throws {
        let calculator = TASFromAltimeterCalculator(indicatedAltitude: 15000, altimeterSetting: 29.85, outsideAirTemp: -10, indicatedAirSpeed: 120)

        let expectedTAS = 130.0 // Approximate True Airspeed at 15000 ft under the given conditions

        #expect(abs(calculator.trueAirSpeed - expectedTAS) < 5.0, "True Airspeed should be approximately 130.0 knots at 15000 feet with -10°C outside air temp")
    }
}
