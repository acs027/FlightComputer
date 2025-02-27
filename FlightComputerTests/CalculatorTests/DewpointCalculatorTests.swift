//
//  DewpointCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import Foundation
import Testing
@testable import FlightComputer

struct DewpointCalculatorTests {

    @Test func validDewpointCalculation() async throws {
        let calculator = DewpointCalculator(airTemp: 25, relativeHumidity: 60)
        
        let alpha = 17.27
        let beta = 237.7
        let intermediateValue = (alpha * 25) / (beta + 25) + log(60 / 100)
        let expectedDewpoint = (beta * intermediateValue) / (alpha - intermediateValue)

        #expect(calculator.dewpoint == expectedDewpoint, "Dewpoint should be correctly calculated")
    }

    @Test func relativeHumidityZero() async throws {
        let calculator = DewpointCalculator(airTemp: 20, relativeHumidity: 0)
        
        #expect(calculator.dewpoint == nil, "Dewpoint should be nil when relative humidity is 0%")
    }

    @Test func relativeHumidityAbove100() async throws {
        let calculator = DewpointCalculator(airTemp: 15, relativeHumidity: 105)
        
        #expect(calculator.dewpoint == nil, "Dewpoint should be nil when relative humidity is above 100%")
    }

    @Test func dewpointAt100PercentHumidity() async throws {
        let calculator = DewpointCalculator(airTemp: 10, relativeHumidity: 100)
        
        #expect(calculator.dewpoint == 10, "Dewpoint should be equal to air temperature when RH is 100%")
    }

    @Test func negativeTemperatureDewpoint() async throws {
        let calculator = DewpointCalculator(airTemp: -5, relativeHumidity: 50)
        
        let alpha = 17.27
        let beta = 237.7
        let intermediateValue = (alpha * -5) / (beta + -5) + log(50 / 100)
        let expectedDewpoint = (beta * intermediateValue) / (alpha - intermediateValue)

        #expect(calculator.dewpoint == expectedDewpoint, "Dewpoint should be correctly calculated for negative temperatures")
    }
}

