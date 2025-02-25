//
//  WindCorrectionViewModel.swift
//  FlightComputer
//
//  Created by ali cihan on 19.02.2025.
//

import Foundation

@Observable class WindCorrectionViewModel {
    var wCACalculator = WindCorrectionAngleCalculator()
    var flightTimeCalculator = FlightTimeCalculator()
    var fuelConsumptionCalc = FuelConsumptionCalculator()
    
    var circleRadius: Double = 0
    var maxSpeed: Double {
        max(wCACalculator.trueAirSpeed, wCACalculator.windSpeed, wCACalculator.groundSpeed ?? 0, 1)
    }
    
    var windArrowDegree: Double {
        (180 + wCACalculator.windDirection).truncatingRemainder(dividingBy: 360)
    }
    var windArrowHeight: Double {
        if wCACalculator.windSpeed > 0 {
            50
        } else {
            0
        }
    }
    var windArrowOffset: Double {
        (circleRadius - windArrowHeight) / 2
    }
    
    var courseArrowHeight: Double {
        max(circleRadius * 0.5 * ((wCACalculator.groundSpeed ?? 1) / maxSpeed), 1)
    }
    
    var courseArrowOffset: Double {
        -courseArrowHeight / 2
    }
    
    var tasArrowHeight: Double {
        max(circleRadius * 0.5 * (wCACalculator.trueAirSpeed / maxSpeed), 1)
    }
    var tasArrowOffset: Double {
        -tasArrowHeight / 2
    }
}
