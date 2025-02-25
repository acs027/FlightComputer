//
//  SpeedOfSoundCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import Foundation

struct SpeedOfSoundCalculator {
    var altitude: Double = 0 // Altitude in feet or meters
    var standardTemperature: Double = 0 // Standard Temperature in Celsius
    var selectedUnit: SpeedUnit = .knots // The unit to display speed in (Knots, MPH, KM/H, or M/S)
    
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
    
    var calculatedSpeed: Double {
        switch selectedUnit {
        case .knots:
            return speedOfSoundAtAltitude * 1.94384 // Convert m/s to knots
        case .mph:
            return speedOfSoundAtAltitude * 2.23694 // Convert m/s to miles per hour
        case .kmh:
            return speedOfSoundAtAltitude * 3.6 // Convert m/s to km/h
        case .metersPerSecond:
            return speedOfSoundAtAltitude // Speed in m/s
        }
    }
    
    var machNumber: Double {
        // Mach number calculation
        return calculatedSpeed / 340.29 // Divide by the speed of sound at sea level (340.29 m/s)
    }
}
