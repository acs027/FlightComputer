//
//  WindSideProViewModel.swift
//  FlightComputer
//
//  Created by ali cihan on 11.03.2025.
//

import Foundation

enum ProController: CaseIterable {
    case vertical
    case rotation
    case wind
    case line
    
    var systemImage: String {
        switch self {
        case .vertical:
            "arrow.up.and.line.horizontal.and.arrow.down"
        case .rotation:
            "arrow.trianglehead.2.clockwise.rotate.90"
        case .wind:
            "wind"
        case .line:
            "line.horizontal.3.decrease"
        }
    }
}

@Observable
class WindSideProViewModel: WindSideViewModelProtocol {
    var step: WCACalculationSteps = .result
    var mode: Mode = .normal
    
    var windDirection: Double = 0
    
    var isWindDirectionReverse: Bool = false
    var isWindMarkRotationEnabled: Bool = false
    
    var islineShowing: Bool = false
    var isLineRotationEnabled: Bool = false
    var lineAngleStartDegree: Double = 0
    
    var controller: ProController = .vertical
    var isControllerShowing = false
    
    var referenceHeight: Double = 10
    var unitHeight: Double {
        let height = referenceHeight * 0.829
        return height / 220
    }
    
    var verticalRange: ClosedRange<CGFloat> {
        let highestPoint = unitHeight * 130
        let lowestPoint = -unitHeight * 90
        return lowestPoint...highestPoint
    }
    
    var markRange: ClosedRange<CGFloat> {
        let highestPoint: CGFloat = .zero
        let lowestPoint: CGFloat = -unitHeight * 50
        return lowestPoint...highestPoint
    }
    
    func verticalStepperIncrement(value: Double) -> Double {
        if value > -unitHeight * 89 {
            return value - unitHeight
        }
        return -unitHeight * 90
    }
    
    func verticalStepperDecrement(value: Double) -> Double {
        if value < unitHeight * 129 {
            return value + unitHeight
        }
        return unitHeight * 130
    }
    
    func markStepperIncrement(value: Double) -> Double {
        if value > -unitHeight * 49 {
            return value - unitHeight
        }
        return -unitHeight * 50
    }
    
    func markStepperDecrement(value: Double) -> Double {
        if value < -unitHeight {
            return value + unitHeight
        }
        return 0
    }
    
    func calculateVerticalOffset(value: Double) -> Double {
        (170 - value) * unitHeight
    }
    
    func calculateMarkOffset(value: Double) -> Double {
        let markOffset = -value * unitHeight
        return markOffset
    }
    
    func isVerticalOffsetInRange(value: Double) -> Bool {
        let highestPoint = unitHeight * 130
        let lowestPoint = -unitHeight * 90
        let range = lowestPoint...highestPoint
        let convertedValue = (170 - value) * unitHeight
        return range.contains(convertedValue)
    }
    
    func isAngleInRange(value: Double) -> Bool {
        let range: ClosedRange<Double> = 0...360
        return range.contains(value)
    }
    
    func isLineAngleInRange(value: Double) -> Bool {
        let range: ClosedRange<Double> = -50...50
        return range.contains(value)
    }
    
    func isMarkInRange(value: Double) -> Bool {
        let highestPoint: Double = 0
        let lowestPoint = -unitHeight * 50
        let range = lowestPoint...highestPoint
        let convertedValue = -value * unitHeight
        return range.contains(convertedValue)
    }
    
    func speedValue(verticalOffset: Double) -> Double {
        170 - verticalOffset / unitHeight
    }
    
    func markDegree(rotation degrees: Double) -> Double {
        (windDirection - degrees + 360).truncatingRemainder(dividingBy: 360)
    }
    
    func markValue(markOffset: Double) -> Double {
        -markOffset / unitHeight
    }
    
    func angleLineOffset(angle radian: Double) -> (x: Double, y: Double) {
        let y = (40 * unitHeight) * (1 - cos(radian))
        let x = sin(radian) * (40 * unitHeight)
        return (x,y)
    }
    
    func verticalOffsetByMode(vertical offset: Double) -> Double {
        offset
    }
    
    func markOffsetByMode(mark offset: Double) -> Double {
        if isWindDirectionReverse {
                return -offset
            } else {
                return offset
            }
    }
    
    func calculateWindMarkDegree(windDirection degree: Double, rotation rotDegree: Double) -> Double {
        if isWindMarkRotationEnabled {
            return (degree - rotDegree + 360).truncatingRemainder(dividingBy: 360)
        } else {
            return 0
        }
    }
    
    func calculateLineDegree(rotation degree: Double) -> Double {
        if isLineRotationEnabled {
            return -degree + lineAngleStartDegree
        } else {
            return 0
        }
        
    }
    
}
