//
//  WindSideProViewModel.swift
//  FlightComputer
//
//  Created by ali cihan on 11.03.2025.
//

import Foundation

struct LineAngleInfo {
    let id: UUID = UUID()
    var degree: Double
    var rotation:Double
    var isDynamic: Bool
}

@Observable
class WindSideProViewModel {
    var windMarkOffset: CGSize = .zero
    var verticalOffset: CGFloat = 0
    
    var lineAngleInfos: [LineAngleInfo] = []
    var lineAngle: Double = 5
    var lineAngleStartDegree: Double = 0
    var islineShowing: Bool = false
    var isLineRotationEnabled: Bool = false
    
    var rotationDegree: Double = 0
    var windDirection: Double = 0
    
    var isHighSpeed: Bool = false
    var isWindDirectionReverse: Bool = false
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
        if !isWindMarkRotationEnabled {
            return 0
        }
        return (windDirection - rotationDegree + 360).truncatingRemainder(dividingBy: 360)
    }
    
    func angleLineOffset(angle radian: Double) -> (x: Double, y: Double) {
        let y = (40 * unitHeight) * (1 - cos(radian))
        let x = sin(radian) * (40 * unitHeight)
        return (x,y)
    }
    
    func windMarkOffsetByMode() -> CGSize {
        if isWindDirectionReverse {
            var newWindMarkOffset = windMarkOffset
            newWindMarkOffset.height = -windMarkOffset.height
            return newWindMarkOffset
            } else {
                return windMarkOffset
            }
    }
    
    func lineDegree(rotation degree: Double, startDegree: Double, isDynamic: Bool) -> Double {
        if isDynamic {
            return -degree + startDegree
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
        if windMarkOffset.height != 0 {
            debugPrint("\(windMarkOffset)  markoffset")
            windMarkOffset.height *= newValue.height/oldValue.height
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
    
    func addLine() {
        if lineAngleInfos.count < 5 {
            let line = LineAngleInfo(degree: lineAngle, rotation: rotationDegree, isDynamic: isLineRotationEnabled)
            lineAngleInfos.append(line)
        }
        return
    }
}
