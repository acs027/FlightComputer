//
//  SpeedOfSoundCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import Foundation

struct SpeedOfSoundCalculator {
    var altitude: Double = 0 {
        didSet {
            calculateStandartTemperature()
        }
    }
    var standardTemperature: Double = 15

    var altitudeUnit = Distance.feet {
        didSet {
            calculateStandartTemperature()
        }
    }
    
    var standardTemperatureUnit = Temperature.celsius {
        didSet {
            calculateStandartTemperature()
        }
    }
    var speedUnit = Speed.metersPerSecond
    
    var speedOfSoundAtAltitude: Double {
        let temperatureAtAltitude = standardTemperatureUnit.toCelcius(value: standardTemperature)
        
        // Calculate the speed of sound at the altitude
        let speedOfSoundMS = 20.05 * sqrt(temperatureAtAltitude + 273.15)
        return Speed.metersPerSecond.convert(value: speedOfSoundMS, to: speedUnit)
    }
    
    mutating func calculateStandartTemperature() {
        let temperatureLapseRate = -0.00649 // Lapse rate in °C/m
        let altitudeInMeters = altitudeUnit.convert(value: altitude, to: .meters)
        let temperatureAtAltitude = 15 + (altitudeInMeters * temperatureLapseRate)
        self.standardTemperature = Temperature.celsius.convert(value: temperatureAtAltitude, to: standardTemperatureUnit)
    }
    
}

