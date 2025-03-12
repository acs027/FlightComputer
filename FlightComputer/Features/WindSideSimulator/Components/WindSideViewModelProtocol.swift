//
//  WindSideViewModelProtocol.swift
//  FlightComputer
//
//  Created by ali cihan on 11.03.2025.
//

import Foundation

protocol WindSideViewModelProtocol {
    var verticalRange: ClosedRange<CGFloat> { get }
    var markRange: ClosedRange<CGFloat> { get }
    var unitHeight: Double { get }
    func verticalStepperIncrement(value: Double) -> Double
    func verticalStepperDecrement(value: Double) -> Double
    func isVerticalOffsetInRange(value: Double) -> Bool
    func calculateVerticalOffset(value: Double) -> Double
    func markStepperIncrement(value: Double) -> Double
    func markStepperDecrement(value: Double) -> Double
    func isMarkInRange(value: Double) -> Bool
    func calculateMarkOffset(value: Double) -> Double
}
