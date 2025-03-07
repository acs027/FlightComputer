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
            switch vm.step {
            case .trueCourse, .windDirection: WindSideAngleSlider(vm: vm, rotation: $rotation, step: vm.step)
            case .windVelocity: WindSideWindSpeedSlider(vm: vm, markOffset: $markOffset, markValue: vm.markValue(markOffset: markOffset))
            case .trueAirSpeed: WindSideTASSlider(vm: vm, verticalOffset: $verticalOffset, speedValue: vm.speedValue(verticalOffset: verticalOffset))
            case .result: EmptyView()
            }
            HStack {
                backButton
                nextButton
            }
        }
        .foregroundStyle(Constants.controllerViewFgColor)
    }
}
