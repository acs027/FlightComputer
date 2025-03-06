//
//  CustomNumberFormatter.swift
//  FlightComputer
//
//  Created by ali cihan on 21.02.2025.
//

import Foundation

struct FormatterUtils {
    static let sharedNumberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        formatter.usesGroupingSeparator = false
        return formatter
    }()
    
    static func formatTime(_ seconds: Double) -> String {
        if seconds > 0 {
            let totalSeconds = Int(seconds)
            let hours = totalSeconds / 3600
            let minutes = (totalSeconds % 3600) / 60
            let secondsLeft = totalSeconds % 60
            return String(format: "%02d:%02d:%02d", hours, minutes, secondsLeft)
        }
        return ""
    }
}
