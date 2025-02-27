//
//  WindDirectionSpeedCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 26.02.2025.
//

import Foundation
import Foundation
import Testing
@testable import FlightComputer

struct WindDirectionSpeedCalculatorTests {
    
    @Test
    func testWindSpeed() async throws {
        // Arrange: Create a test instance with known values
        let calculator = WindDirectionSpeedCalculator(heading: 90, trueAirSpeed: 150, trueCourse: 270, groundSpeed: 120)
        
        // Act: Get the wind speed
        let windSpeed = calculator.windSpeed
        // Assert: Check if the wind speed is correct (This is a hypothetical value, you may adjust it based on your calculation)
        #expect(windSpeed == 270, "Wind speed should be around 120 knots")
    }
    
    @Test
    func testWindDirection() async throws {
        // Arrange: Create a test instance with known values
        let calculator = WindDirectionSpeedCalculator(heading: 90, trueAirSpeed: 150, trueCourse: 270, groundSpeed: 120)
        
        // Act: Get the wind direction
        let windDirection = calculator.windDirection
        
        // Assert: Check if the wind direction is correct (This is a hypothetical value, you may adjust it based on your calculation)
        #expect(windDirection > 89 && windDirection < 91, "Wind direction should be around 90 degrees")
    }
    
    @Test
    func testEdgeCase() async throws {
        // Arrange: Test with edge values, such as when heading and course are the same
        let calculator = WindDirectionSpeedCalculator(heading: 0, trueAirSpeed: 150, trueCourse: 0, groundSpeed: 0)
        
        // Act: Get the wind speed and direction
        let windSpeed = calculator.windSpeed
        let windDirection = calculator.windDirection
        
        // Assert: Verify wind speed and direction are 0
        #expect(windSpeed == 150, "Wind speed should be 0 when ground speed is 0.")
        #expect(windDirection == 0, "Wind direction should be 0 when heading and course are the same.")
    }
}
