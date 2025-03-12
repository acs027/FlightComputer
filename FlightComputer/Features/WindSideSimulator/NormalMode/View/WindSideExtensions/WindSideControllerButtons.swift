//
//  WindSideControllerButtons.swift
//  FlightComputer
//
//  Created by ali cihan on 7.03.2025.
//

import SwiftUI

extension WindSideView {
    //MARK: Controller buttons
    var controllerButtons: some View {
        VStack {
            HStack {
                Spacer()
                VStack(spacing: 30) {
                    toggleProModeButton
                    centerButton
                    correctionSpeedDownButton
                }
            }
            Spacer()
            HStack {
                setValuesButton
                toggleValuesButton
            }
            .foregroundStyle(Constants.mainButtonColor)
            .frame(height: 50)
        }
        .padding(.horizontal, 20)
    }
    
    var correctionSpeedDownButton: some View {
        CircleButton(function: downMethodCorrection, tint: .white, title: "Correction")
        .opacity(vm.mode == .tafa ? 1 : 0)

    }
    
    var toggleProModeButton: some View {
        CircleButton(function: toggleMethod, tint: Constants.centerButtonBgColor, title: vm.mode.rawValue)
    }
    
    var centerButton: some View {
        CircleButton(function: centerView, tint: Constants.centerButtonBgColor, imageSystemName: "scope", title: "Center")
    }
    
    var setValuesButton: some View {
        Button {
            vm.isControllerShowing.toggle()
        } label: {
            UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 15)
                .frame(maxWidth: 200)
                .overlay {
                    Text("Set Values")
                        .foregroundStyle(Constants.buttonTextColor)
                }
        }
    }
    
    var toggleValuesButton: some View {
        Button {
            vm.isValuesShowing.toggle()
        } label: {
            UnevenRoundedRectangle(bottomTrailingRadius: 15, topTrailingRadius: 15)
                .frame(maxWidth: 200)
                .overlay {
                    Text("Toggle Values")
                        .foregroundStyle(Constants.buttonTextColor)
                }
        }
    }
    
    var nextButton: some View {
        Button {
            vm.setValue(for: vm.step, speedValue: vm.speedValue(verticalOffset: verticalOffset), markValue: vm.markValue(markOffset: markOffset), angle: rotation.degrees)
            vm.step.next()
        } label: {
            Text("Next")
                .foregroundStyle(Constants.buttonTextColor)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Constants.nextButtonColor)
                )
        }
    }
    
    var backButton: some View {
        Button {
            vm.step.back()
        } label: {
            Text("Back")
                .foregroundStyle(Constants.buttonTextColor)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Constants.backButtonColor)
                )
        }
    }
    
    var newButton: some View {
        Button {
            new()
            vm.step.next()
        } label: {
            Text("New")
                .foregroundStyle(Constants.buttonTextColor)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Constants.nextButtonColor)
                )
        }
    }
    
    //MARK: Functions
    func centerView() {
        let offset = cos(Angle(degrees: vm.markDegree(rotation: rotation.degrees)).radians) * markOffset
        pan.height = -verticalOffset
        pan.width = -offset
    }
    
    func new() {
        vm.new()
        rotation = .zero
        verticalOffset = .zero
        markOffset = 0
        
    }
    
    func toggleMethod() {
        vm.mode.toggle()
    }
}
