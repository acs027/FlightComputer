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
                    Color.clear.frame(width: 50, height: 50)
                    switchToTrackButton
                    switchToHeadingButton
                    switchToWindButton
                    centerButton
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
        .padding(20)
    }
    
    var switchToTrackButton: some View {
        CircleButton(function: switchToTrack, tint: vm.calculationStepType == .driftTrack(.tas) ? Color.green : Constants.centerButtonBgColor, title: "TC")
    }
    var switchToHeadingButton: some View {
        CircleButton(function: switchToHeading, tint: vm.calculationStepType == .driftHeading(.tas) ? Color.green : Constants.centerButtonBgColor, title: "H")
    }
    var switchToWindButton: some View {
        CircleButton(function: switchToWind, tint: vm.calculationStepType == .windCalculator(.tas) ? Color.green : Constants.centerButtonBgColor, title: "W")
    }
    
    
    
    var centerButton: some View {
        CircleButton(function: centerTheView, tint: Constants.centerButtonBgColor, imageSystemName: "scope", title: "Center")
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
            vm.nextButtonHandler()
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
            vm.backButtonHandler()
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
            reset()
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
    
    func switchToTrack() {
        vm.calculationStepType = .driftTrack(.tas)
    }
    
    func switchToHeading() {
        vm.calculationStepType = .driftHeading(.tas)
    }
    
    func switchToWind() {
        vm.calculationStepType = .windCalculator(.tas)
    }
    
    func centerTheView() {
        withAnimation {
            pan.height = -vm.verticalOffset
        }
    }
}
