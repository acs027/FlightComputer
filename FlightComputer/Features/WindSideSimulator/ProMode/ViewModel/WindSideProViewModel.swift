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
class WindSideProViewModel {
    var lineAngle: Double = 5
    var windMarkOffset: CGFloat = 0
    var verticalOffset: CGFloat = 0
    
    var rotationDegree: Double = 0
    var windDirection: Double = 0
    var lineAngleStartDegree: Double = 0
    
    
    var isHighSpeed: Bool = false
    var isWindDirectionReverse: Bool = false
    var islineShowing: Bool = false
    var isLineRotationEnabled: Bool = false
    var isWindMarkRotationEnabled: Bool = false
    
    @ObservationIgnored var screenWidth: CGFloat = 1
    @ObservationIgnored var componentWidth: CGFloat = 1
    func scaleValueFitTheView() -> CGFloat  {
        screenWidth / componentWidth
    }
    
    var controller: ProController = .vertical
    var isControllerShowing = false
    
    var referenceHeight: Double = 10
    var unitHeight: Double {
        let height = referenceHeight * 0.829
        return height / 220
    }
    
    func windMarkDegree() -> Double {
        (windDirection - rotationDegree + 360).truncatingRemainder(dividingBy: 360)
    }
    
    func angleLineOffset(angle radian: Double) -> (x: Double, y: Double) {
        let y = (40 * unitHeight) * (1 - cos(radian))
        let x = sin(radian) * (40 * unitHeight)
        return (x,y)
    }
    
    func windMarkOffsetByMode(mark offset: Double) -> Double {
        if isWindDirectionReverse {
                return -offset
            } else {
                return offset
            }
    }
    
    func lineDegree(rotation degree: Double) -> Double {
        if isLineRotationEnabled {
            return -degree + lineAngleStartDegree
        } else {
            return 0
        }
    }
    
    func geometryChangeHandler(newValue: CGSize, oldValue: CGSize) {
        if oldValue.height != newValue.height {
            referenceHeight = newValue.height
        }
        if oldValue.width != newValue.width {
            screenWidth = newValue.width
        }
        
        if verticalOffset != 0 {
            debugPrint(newValue)
            verticalOffset *= newValue.height/oldValue.height
        }
        if windMarkOffset != 0 {
            debugPrint("\(windMarkOffset)  markoffset")
            windMarkOffset *= newValue.height/oldValue.height
        }
    }
    
    func backgroundOnAppearHandler(size: CGSize) {
        let height = size.height
        if screenWidth != size.width {
            screenWidth = size.width
        }
        if referenceHeight != height {
            referenceHeight = height
        }
    }
    
    
}
