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
                    ExpandableButton {
                        resetButton
                        centerButton
                        highSpeedButton
                    }
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
        .padding(20)
    }
    
    var rotationController: some View {
        VStack {
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
            HStack {
                Button(action: addLine) {
                    Text("Add Line")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Spacer()
                ForEach(vm.lineAngleInfos, id:\.id) { lineAngle in
                    Text(String(format: "%.0f", (lineAngle.degree)) )
                        .shadow(radius: 0.5)
                        .frame(width: 40, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 3)
                                .foregroundStyle(.red)
                        )
                        .onTapGesture {
                            vm.lineAngleInfos.removeAll(where: {$0.id == lineAngle.id})
                        }
                }  
            }
        }
    }
    
    var highSpeedButton: some View {
        CircleButton(function: toggleSpeed, tint: Constants.centerButtonBgColor, title: "Speed")
    }
    
    var centerButton: some View {
        CircleButton(function: centerView, tint: Constants.centerButtonBgColor, imageSystemName: "scope", title: "Center")
    }
    
    var resetButton: some View {
        CircleButton(function: reset, tint: Constants.centerButtonBgColor, title: "Reset")
    }
    
    
    var trueIndexSlider: some View {
        WindSideTASSlider(verticalOffset: $vm.verticalOffset, unitHeight: vm.unitHeight, isHighSpeed: vm.isHighSpeed)
    }
    
    var angleSlider: some View {
        WindSideAngleSlider(rotation: $vm.rotationDegree)
    }
    
    var windSlider: some View {
        WindSideWindSpeedSlider(markOffset: $vm.windMarkOffset.height, unitHeight: vm.unitHeight, isHighSpeed: vm.isHighSpeed)
    }
    
    var lineSlider: some View {
        WindSideProLineAngleSlider(lineDegree: $vm.lineAngle)
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
        let offset = cos(Angle(degrees: vm.windMarkDegree()).radians) * vm.windMarkOffset.height
        pan.height = -vm.verticalOffset
        pan.width = -offset
    }
    
    private func tideLineAngleButtonHandler() {
        vm.lineAngleStartDegree = vm.rotationDegree
        vm.isLineRotationEnabled.toggle()
    }
    
    private func tideWindMarkButtonHandler() {
        vm.windDirection = vm.rotationDegree
        vm.isWindMarkRotationEnabled.toggle()
    }
    
    private func reset() {
        vm.windDirection = .zero
        vm.rotationDegree = .zero
        vm.isWindMarkRotationEnabled = false
        vm.isLineRotationEnabled = false
        vm.lineAngleStartDegree = .zero
        vm.windMarkOffset = .zero
    }
    
    func toggleSpeed() {
        vm.isHighSpeed.toggle()
    }
    
    func addLine() {
        vm.addLine()
    }
}
