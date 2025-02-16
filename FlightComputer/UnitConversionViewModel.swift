//
//  UnitConversionViewModel.swift
//  FlightComputer
//
//  Created by ali cihan on 13.02.2025.
//

import Foundation

@Observable class UnitConversionViewModel {
    var unitConversion = UnitConversion()
    var selectedConversion: ConversionType = .area
}
