//
//  WindSideView.swift
//  FlightComputer
//
//  Created by ali cihan on 15.02.2025.
//

import SwiftUI

struct WindSideView: View {
    @State var vm = WindSideViewModel()
    @State var rotation: Angle = Angle(degrees: 0)
    
//    var lineAngle: Angle = Angle(degrees: 10)
    @State var height: Double = 0
    @State var scale: CGFloat = 1
    @GestureState var gestureScale: CGFloat = 1
    var totalScale: CGFloat { scale * gestureScale }
    
    
    @GestureState var gestureTrueIndex: CGFloat = 0
    @State var verticalOffset: CGFloat = 0
    
    @State var markOffset: CGFloat = 0
    
    @State var pan: CGOffset = .zero
    @GestureState var gesturePan: CGOffset = .zero
    var totalPan: CGOffset { pan + gesturePan }
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .center) {
            windSideComponents
            controllerButtons
            values
        }
        .background(Constants.bgColor)
        .simultaneousGesture(
            panGesture
        )
        .simultaneousGesture(
            magnifyGesture
        )
        .sheet(isPresented: $vm.isControllerShowing) {
            controllerView
                .padding()
                .presentationBackground(Constants.sheetBg)
                .presentationDetents([.medium, .fraction(0.4)])
        }
        .onChange(of: vm.step) { oldValue, newValue in
            vm.handleStepChange(newValue: newValue)
        }
        .onChange(of: vm.mode) { oldValue, newValue in
            verticalOffset = vm.calculateVerticalOffset(value: vm.wCACalculator.trueAirSpeed)
        }
    }
    
    //MARK: Constants
    struct Constants {
        static let bgColor: Color = Color(.systemGroupedBackground)
        static let controllerViewFgColor: Color = .primary
        static let mainButtonColor: AnyGradient = Color.blue.gradient
        static let buttonTextColor: Color = Color(.tertiarySystemBackground)
        static let nextButtonColor: AnyGradient = Color.green.gradient
        static let backButtonColor: AnyGradient = Color.red.gradient
        static let sheetBg: Color = Color(.systemGroupedBackground)
        static let centerButtonBgColor: Color = Color(.systemBackground)
    }
}

#Preview {
    WindSideView()
}
