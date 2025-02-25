//
//  MachSpeedCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import Foundation

struct MachSpeedCalculator {
    var altitude: Double = 0// Altitude in feet or meters
    var standardTemperature: Double = 0 // Standard Temperature in Celsius
    var selectedSpeedUnit: SpeedUnit = .knots // The unit to display speed in (Knots, MPH, KM/H, or M/S)
    
    enum SpeedUnit {
        case knots
        case mph
        case kmh
        case metersPerSecond
    }
    
    private var speedOfSoundAtAltitude: Double {
        // Constants for speed of sound calculation based on altitude and temperature
        let temperatureLapseRate = -0.00649 // Lapse rate in °C/m
//        let temperatureAtSeaLevel = 15.0 // Standard temperature at sea level in °C
        
        // Calculate the temperature at the given altitude (assuming standard conditions)
        let temperatureAtAltitude = standardTemperature + (altitude * temperatureLapseRate)
        
        // Calculate the speed of sound at the altitude
        let speedOfSound = 331.3 + (0.6 * temperatureAtAltitude) // Speed of sound at given altitude in m/s
        return speedOfSound
    }
    
    var machSpeed: Double {
        // Mach speed in meters per second based on the Mach number and the speed of sound at altitude
        return 340.29 * speedOfSoundAtAltitude // Approximate value of the speed of sound at sea level
    }
    
    var calculatedSpeed: Double {
        switch selectedSpeedUnit {
        case .knots:
            return machSpeed * 1.94384 // Convert m/s to knots
        case .mph:
            return machSpeed * 2.23694 // Convert m/s to miles per hour
        case .kmh:
            return machSpeed * 3.6 // Convert m/s to km/h
        case .metersPerSecond:
            return machSpeed // Speed in m/s
        }
    }
    
    var machNumber: Double {
        // Mach number calculation
        return machSpeed / 340.29 // Divide by the speed of sound at sea level (340.29 m/s)
    }
}
