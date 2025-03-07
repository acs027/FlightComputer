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
                centerButton
            }
            .padding()
            Spacer()
            HStack {
                setValuesButton
                toggleValuesButton
            }
            .foregroundStyle(Constants.mainButtonColor)
            .frame(height: 50)
        }
        .padding()
    }
    
    var centerButton: some View {
        Button {
            centerView()
        } label: {
            Image(systemName: "scope")
                .font(.largeTitle)
                .background(
                    Circle()
                        .tint(Constants.centerButtonBgColor)
                )
        }
    }
    
    var setValuesButton: some View {
        Button {
            vm.isControllerShowing.toggle()
        } label: {
            UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 15)
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
    
    //MARK: Functions
    func centerView() {
        print(vm.markDegree(rotation: rotation.degrees))
        let offset = cos(Angle(degrees: vm.markDegree(rotation: rotation.degrees)).radians) * markOffset
        pan.height = -verticalOffset
        pan.width = -offset
    }
}
