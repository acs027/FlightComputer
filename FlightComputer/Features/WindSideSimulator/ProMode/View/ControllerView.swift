//
//  ControllerView.swift
//  FlightComputer
//
//  Created by ali cihan on 11.03.2025.
//

import SwiftUI



extension WindSideProView {
    @ViewBuilder
    var controllerView: some View {
        Group {
            switch vm.controller {
            case .vertical:
                verticalController
            case .rotation:
                rotationController
            case .wind:
                windController
            case .line:
                lineController
            }
        }
        .foregroundStyle(Constants.controllerViewFgColor)
    }
    
    var panelControlButtons: some View {
        VStack {
            HStack {
                Spacer()
                VStack(spacing: 30) {
                    resetButton
                    centerButton
                }
                
            }
            Spacer()
            HStack {
                ForEach(ProController.allCases, id: \.systemImage) { controller in
                    Button{
                        vm.isControllerShowing.toggle()
                        vm.controller = controller
                    } label : {
                        Image(systemName: controller.systemImage)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.noteditabletextfieldbg)
                            )
                            
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    var rotationController: some View {
        VStack {
            HStack {
                Text("Enable line rotation: ")
                Spacer()
                tideLineAngleButton
            }
            HStack {
                Text("Enable wind speed mark rotation: ")
                Spacer()
                tideWindMarkButton
            }
            angleSlider
        }
    }
    
    var verticalController: some View {
        VStack {
            trueIndexSlider
        }
    }
    
    var windController: some View {
        VStack {
            HStack {
                Text("Reverse wind: ")
                Spacer()
                reverseWindDirectionButton
            }
            windSlider
        }
    }
    
    var lineController: some View {
        VStack {
            HStack {
                Text("Show Line ")
                Spacer()
                toggleLineButton
            }
            HStack {
                Text("Enable line rotation :")
                Spacer()
                tideLineAngleButton
            }
            lineSlider
        }
    }
    
    var centerButton: some View {
        CircleButton(function: centerView, tint: Constants.centerButtonBgColor, imageSystemName: "scope", title: "Center")
    }
    
    var resetButton: some View {
        CircleButton(function: reset, tint: .white, title: "Reset")
    }
    
    
    var trueIndexSlider: some View {
        WindSideTASSlider(vm: vm, verticalOffset: $verticalOffset, speedValue: vm.speedValue(verticalOffset: verticalOffset))
    }
    
    var angleSlider: some View {
        WindSideAngleSlider(isAngleInRange: vm.isAngleInRange, rotation: $rotation, step: vm.step)
    }
    
    var windSlider: some View {
        WindSideWindSpeedSlider(vm: vm, markOffset: $markOffset, markValue: vm.markValue(markOffset: markOffset))
    }
    
    var lineSlider: some View {
        WindSideProLineAngleSlider(isAngleInRange: vm.isLineAngleInRange, lineAngle: $lineAngle)
    }
    
    var tideLineAngleButton: some View {
        ProSideButton(condition: $vm.isLineRotationEnabled, function: tideLineAngleButtonHandler)
    }
    
    var tideWindMarkButton: some View {
        ProSideButton(condition: $vm.isWindMarkRotationEnabled, function: tideWindMarkButtonHandler)
    }
    
    var reverseWindDirectionButton: some View {
        ProSideButton(condition: $vm.isWindDirectionReverse)
    }
    
    var toggleLineButton: some View {
        ProSideButton(condition: $vm.islineShowing)
    }
    
    //MARK: Functions
    func centerView() {
        let offset = cos(Angle(degrees: vm.markDegree(rotation: rotation.degrees)).radians) * markOffset
        pan.height = -verticalOffset
        pan.width = -offset
    }
    
    private func tideLineAngleButtonHandler() {
        vm.lineAngleStartDegree = rotation.degrees
        vm.isLineRotationEnabled.toggle()
    }
    
    private func tideWindMarkButtonHandler() {
        windDirection = rotation
        vm.isWindMarkRotationEnabled.toggle()
    }
    
    private func reset() {
        windDirection = .zero
        rotation = .zero
        vm.isWindMarkRotationEnabled = false
        vm.isLineRotationEnabled = false
        vm.lineAngleStartDegree = .zero
        markOffset = .zero
    }
}
