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
            stepButtons
            switch vm.step {
            case .trueCourse, .windDirection: WindSideAngleSlider(vm: vm, rotation: $rotation, step: vm.step)
            case .windVelocity: WindSideWindSpeedSlider(vm: vm, markOffset: $markOffset, markValue: vm.markValue(markOffset: markOffset))
            case .trueAirSpeed: WindSideTASSlider(vm: vm, verticalOffset: $verticalOffset, speedValue: vm.speedValue(verticalOffset: verticalOffset))
            case .result: EmptyView()
            }
            
            if vm.step != .result {
                HStack {
                    backButton
                    nextButton
                }
            } else {
                newButton
            }
        }
        .foregroundStyle(Constants.controllerViewFgColor)
    }
    
    var stepButtons: some View {
        HStack {
            ForEach(WCACalculationSteps.allCases, id: \.abbreviation) { step in
                if step != .result {
                    StepButton(title: step.abbreviation) {
                        vm.step = step
                    }
                }
            }
        }
    }
}

struct StepButton: View {
    let title: String
    let function: () -> Void
    var body: some View {
        Button {
            function()
        } label : {
            Text(title)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                )
        }
    }
}
