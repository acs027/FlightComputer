//
//  MachSpeedCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import Foundation

struct MachSpeedCalculator {
    var altitude: Double = 0 {
        didSet {
            calculateStandartTemperature()
        }
    }
    var standardTemperature: Double = 15
    var standardTemperatureUnit: Temperature = .celsius  {
        didSet {
            calculateStandartTemperature()
        }
    }
    var altitudeUnit: Distance = .feet  {
        didSet {
            calculateStandartTemperature()
        }
    }
    var machSpeedUnit: Speed = .metersPerSecond  // Mach speed unit (default is m/s)

    var speed: Double = 0

    var machNumber: Double {
        speed / speedOfSoundAtAltitude
    }
    
    var speedOfSoundAtAltitude: Double {
        let temperatureAtAltitude = standardTemperatureUnit.toCelcius(value: standardTemperature)
        
        // Calculate the speed of sound at the altitude
        let speedOfSoundMS = 20.05 * sqrt(temperatureAtAltitude + 273.15)
        return Speed.metersPerSecond.convert(value: speedOfSoundMS, to: machSpeedUnit)
    }
    
    mutating func calculateStandartTemperature() {
        let temperatureLapseRate = -0.00649 // Lapse rate in °C/m
        let altitudeInMeters = altitudeUnit.convert(value: altitude, to: .meters)
        let temperatureAtAltitude = 15 + (altitudeInMeters * temperatureLapseRate)
        self.standardTemperature = Temperature.celsius.convert(value: temperatureAtAltitude, to: standardTemperatureUnit)
    }
}
