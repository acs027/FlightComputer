//
//  WindSideControllerView.swift
//  FlightComputer
//
//  Created by ali cihan on 7.03.2025.
//

import SwiftUI

extension WindSideView {
    // MARK: Controller View
    @ViewBuilder
    var controllerView: some View {
        VStack {
            switch vm.calculationStepType {
            case .driftHeading(_):
                driftHeadingController
            case .driftTrack(_):
                driftTrackController
            case .windCalculator(_):
                windCalculatorController
            }
            HStack {
                backButton
                nextButton
            }
        }
        .foregroundStyle(Constants.controllerViewFgColor)
    }
    
    var windCalculatorController: some View {
        Group {
            switch vm.calculationStepType {
            case .windCalculator(let step):
                switch step {
                case .tas:
                    verticalSlider(title: step.title)
                case .track:
                    rotationSlider(title: step.title)
                case .heading:
                    rotationSlider(title: step.title)
                case .groundSpeed:
                    windSpeedSlider()
                case .result:
                    newButton
                }
            default: EmptyView()
            }
        }
    }
    
    var driftHeadingController: some View {
        Group {
            switch vm.calculationStepType {
            case .driftHeading(let step):
                switch step {
                case .tas:
                    verticalSlider(title: step.title)
                case .windDirection:
                    rotationSlider(title: step.title)
                case .windSpeed:
                    windSpeedSlider()
                case .heading:
                    rotationSlider(title: step.title)
                default:
                    newButton
                }
            default:
                EmptyView()
            }
        }
    }
    
    var driftTrackController: some View {
        Group {
            switch vm.calculationStepType {
            case .driftTrack(let step):
                switch step {
                case .tas:
                    verticalSlider(title: step.title)
                case .windDirection:
                    rotationSlider(title: step.title)
                case .windSpeed:
                    windSpeedSlider()
                case .track:
                    rotationSlider(title: step.title)
                case .correction:
                    rotationSlider(title: step.title)
                default: newButton
                }
            default: EmptyView()
            }
        }
    }
    
    func rotationSlider(title: String) -> some View {
        WindSideAngleSlider(rotation: $vm.rotation, title: title)
    }
    
    func verticalSlider(title: String) -> some View {
        WindSideTASSlider(verticalOffset: $vm.verticalOffset, unitHeight: vm.unitHeight, title: title, isHighSpeed: vm.isHighSpeed)
    }
    
    func windSpeedSlider() -> some View {
        WindSideWindSpeedSlider(markOffset: $vm.windMarkOffset, unitHeight: vm.unitHeight, isHighSpeed: vm.isHighSpeed)
    }
}
