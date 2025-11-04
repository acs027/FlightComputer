//
//  FlightComputerTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 12.02.2025.
//

import XCTest
@testable import FlightComputer

class FlightComputerTests: XCTestCase {
    
    func testFlightTimeCalculation() {
        var calculator = FlightTimeCalculator()
        calculator.distance = 100
        calculator.groundSpeed = 100
        XCTAssertEqual(calculator.flightTime, 3600, "Flight time calculation True")
    }

}
