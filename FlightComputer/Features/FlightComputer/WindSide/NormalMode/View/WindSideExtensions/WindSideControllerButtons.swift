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
                    ExpandableButton(content: {
                        VStack {
                            switchToTrackButton
                            switchToHeadingButton
                            switchToWindButton
                            centerButton
                            highSpeedButton
                        }
                    })
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
    
    var highSpeedButton: some View {
        CircleButton(function: toggleSpeed, tint: Constants.centerButtonBgColor, title: "Speed")
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
                .fill(.primary)
                .frame(maxWidth: 200)
                .overlay {
                    ZStack {
                        UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 15)
                            .stroke(.secondary, lineWidth: 1.5)
                            .shadow(color: .black, radius: 0.5)
                        Text("Set Values")
                            .foregroundStyle(Constants.buttonTextColor)
                    }
                }
        }
    }
    
    var toggleValuesButton: some View {
        Button {
            withAnimation {
                vm.isValuesShowing.toggle()
            }
        } label: {
            UnevenRoundedRectangle(bottomTrailingRadius: 15, topTrailingRadius: 15)
                .fill(.primary)
                .frame(maxWidth: 200)
                .overlay {
                    ZStack {
                        UnevenRoundedRectangle(bottomTrailingRadius: 15, topTrailingRadius: 15)
                            .stroke(.secondary, lineWidth: 1.5)
                            .shadow(color: .black, radius: 0.5)
                        Text("Toggle Values")
                            .foregroundStyle(Constants.buttonTextColor)
                    }
                }
        }
    }

    // Next Button
    var nextButton: some View {
        ControllerButton(function: vm.nextButtonHandler, color: ButtonConstants.buttonTextColor, fillColor: ButtonConstants.nextButtonColor, systemImage: "chevron.right", title: "Next")
    }

    // Back Button
    var backButton: some View {
        ControllerButton(function: vm.backButtonHandler, color: ButtonConstants.buttonTextColor, fillColor: ButtonConstants.backButtonColor, systemImage: "chevron.left", title: "Back")
    }

    // New Button
    var newButton: some View {
        ControllerButton(function: reset, color: ButtonConstants.buttonTextColor, fillColor: ButtonConstants.nextButtonColor, systemImage: "plus", title: "New")
    }

    // Updated Constants Example (assuming you want to keep your existing constants)
    struct ButtonConstants {
        // Original colors
//        struct Button {
            static let buttonTextColor = Color.white
            static let nextButtonColor = Color.blue
            static let backButtonColor = Color.red
//        }
        
        
        // Additional modern color suggestions
        static let modernNextColor = Color(red: 0.2, green: 0.5, blue: 0.9)
        static let modernBackColor = Color(red: 0.6, green: 0.2, blue: 0.2)
        static let modernToggleColor = Color.gray.opacity(0.3)
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
            pan.width = .zero
        }
    }
    
    
    func toggleSpeed() {
        vm.isHighSpeed.toggle()
    }
    
}
