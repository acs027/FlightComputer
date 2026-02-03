//
//  FuelMassCalculatorTests.swift
//  FlightComputerTests
//
//  Created by ali cihan on 2.02.2026.
//

import XCTest
@testable import FlightComputer

class FuelMassCalculatorTests: XCTestCase {
    
    func testAvgasCalculation() {
        var calculator = FuelMassCalculator()
        calculator.fuelType = .avgas
        calculator.volumeUnit = .gallonsUS
        calculator.volume = 1000
        calculator.massUnit = .pounds
        
        let expectedFuelMass: Double = 6000
        
        XCTAssertEqual(calculator.mass, expectedFuelMass, "Fuel mass should be 6000 pounds.")
        
        calculator.volumeUnit = .liters
        calculator.massUnit = .kilograms
        let expectedFuelKgMass: Double = 718
        
        XCTAssertEqual(calculator.mass, expectedFuelKgMass, accuracy: 1, "Fuel mass should be 718 kg.")
    }
    
    func testJetACalculation() {
        var calculator = FuelMassCalculator()
        calculator.fuelType = .jetAOne
        calculator.volumeUnit = .gallonsUS
        calculator.volume = 1000
        calculator.massUnit = .pounds
        
        let expectedFuelMass: Double = 6700
        
        XCTAssertEqual(calculator.mass, expectedFuelMass, "Fuel mass should be 6700 pounds.")
        
        calculator.volumeUnit = .liters
        calculator.massUnit = .kilograms
        let expectedFuelKgMass: Double = 802
        
        XCTAssertEqual(calculator.mass, expectedFuelKgMass, accuracy: 1, "Fuel mass should be 802 kg.")
    }
    
    func testJetBCalculation() {
        var calculator = FuelMassCalculator()
        calculator.fuelType = .jetB
        calculator.volumeUnit = .gallonsUS
        calculator.volume = 1000
        calculator.massUnit = .pounds
        
        let expectedFuelMass: Double = 6500
        
        XCTAssertEqual(calculator.mass, expectedFuelMass, "Fuel mass should be 6500 pounds.")
        
        calculator.volumeUnit = .liters
        calculator.massUnit = .kilograms
        let expectedFuelKgMass: Double = 778
        
        XCTAssertEqual(calculator.mass, expectedFuelKgMass, accuracy: 1, "Fuel mass should be 778 kg.")
        
    }
    
}
