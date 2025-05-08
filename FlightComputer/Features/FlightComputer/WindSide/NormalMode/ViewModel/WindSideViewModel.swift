//
//  WindSideViewModel.swift
//  FlightComputer
//
//  Created by ali cihan on 16.02.2025.
//

import Foundation

@MainActor
@Observable class WindSideViewModel {
    var calculationService = CalculationService()
    
    var calculationStepType: CalculationStepType = .driftHeading(.tas)
    
    var verticalOffset: CGFloat = .zero
    var windMarkOffset: CGSize = .zero
    
    var rotation: Double = 0

    var windDirection: Double = 0

    
    var isHighSpeed: Bool = false
    var isWindMarkRotationEnable: Bool = false
    
    var isControllerShowing = false
    var isValuesShowing = false
    
    @ObservationIgnored var screenWidth: CGFloat = 1
    @ObservationIgnored var componentWidth: CGFloat = 1
    func scaleValueFitTheView() -> CGFloat  {
        screenWidth / componentWidth
    }
    
    var referenceHeight: Double = 10
    var unitHeight: Double {
        let height = referenceHeight * 0.829
        return height / 220
    }
    
    var results: [(label: String, value: Double, type: ValueType)] {
        calculationService.results(type: calculationStepType)
    }
    
    func rotationRadians() -> Double {
        -rotation * .pi / 180
    }

    func windMarkDegree() -> Double {
        if !isWindMarkRotationEnable { return 0 }
        return (windDirection - rotation + 360).truncatingRemainder(dividingBy: 360)
    }
    
    //MARK: -Values
    func speedValue() -> Double {
        let value = 170 - verticalOffset / unitHeight
        return isHighSpeed ? value * 5 : value
    }
    
    func windSpeedValue() -> Double {
        let value = -windMarkOffset.height / unitHeight
        return isHighSpeed ? value * 5 : value
    }
        
    //MARK: -Reset function
    func reset() {
        rotation = 0
        windDirection = 0
        windMarkOffset = .zero
        verticalOffset = .zero
        isWindMarkRotationEnable = false
        calculationStepType.reset()
        calculationService = CalculationService()
    }
    
    
    //MARK: -Next button handler
    func nextButtonHandler() {
        switch calculationStepType {
        case .driftHeading(let driftHeadingStep):
            calculationService.setValues(for: driftHeadingStep, speedValue: speedValue(), markValue: windSpeedValue(), angle: rotation)
            valueSetterForDriftHeading(step: driftHeadingStep)
        case .driftTrack(let driftTrackStep):
            calculationService.setValues(for: driftTrackStep, speedValue: speedValue(), markValue: windSpeedValue(), angle: rotation)
            valueSetterForDriftTrack(step: driftTrackStep)
        case .windCalculator(let windCalculatorStep):
            calculationService.setValues(for: windCalculatorStep, speedValue: speedValue(), markValue: windSpeedValue(), angle: rotation)
            valueSetterForWindCalculator(step: windCalculatorStep)
        }
        calculationStepType.next()
    }
    
    func backButtonHandler() {
        switch calculationStepType {
        case .driftHeading(let driftHeadingStep):
            if driftHeadingStep == .windSpeed {
                isWindMarkRotationEnable = false
                windDirection = 0
            }
        case .driftTrack(let driftTrackStep):
            if driftTrackStep == .windSpeed {
                isWindMarkRotationEnable = false
                windDirection = 0
            }
        case .windCalculator(let windCalculatorStep):
            if windCalculatorStep == .groundSpeed {
                isWindMarkRotationEnable = false
                windDirection = 0
            }
        }
        calculationStepType.back()
    }
    
    
    //MARK: -Value Setters
    func valueSetterForDriftHeading(step: DriftHeadingStep) {
        switch step {
        case .windDirection:
            windDirection = rotation
            isWindMarkRotationEnable = true
        default:
            return
        }
    }
    
    func valueSetterForDriftTrack(step: DriftTrackStep) {
        switch step {
        case .windDirection:
            windDirection = rotation
            isWindMarkRotationEnable = true
            return
        default:
            return
        }
    }
    
    func valueSetterForWindCalculator(step: WindCalculatorStep) {
        switch step {
        case .groundSpeed:
            windDirection = calculationService.windCalculator.heading
            isWindMarkRotationEnable = true
            return
        default:
            return
        }
    }
    
    //MARK: -Geometry Change Handlers
    func geometryChangeHandler(newValue: CGSize, oldValue: CGSize) {
        if oldValue.height != newValue.height {
            referenceHeight = newValue.height
        }
        if oldValue.width != newValue.width {
            screenWidth = newValue.width
        }
        
        if verticalOffset != 0 {
            verticalOffset *= newValue.height/oldValue.height
        }
        if windMarkOffset.height != 0 {
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
    
    func isLineHidden() -> Bool {
        if case .windCalculator  = calculationStepType {
            return true
        } else {
            return false
        }
    }
    
}
