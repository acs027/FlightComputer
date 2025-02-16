//
//  FlightComputerTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 12.02.2025.
//

import Testing
@testable import FlightComputer

struct FlightComputerTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    
    @Test func flightTimeCalculation() async throws {
        var calculator = FlightTimeCalculator()
        calculator.distance = 100
        calculator.groundSpeed = 100
        #expect(calculator.flightTime == 60, "Flight time calculation True")
    }

}
