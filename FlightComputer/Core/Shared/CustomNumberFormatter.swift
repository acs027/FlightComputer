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
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 0
        formatter.usesGroupingSeparator = false
        return formatter
    }()
}
