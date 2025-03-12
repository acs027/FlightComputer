//
//  WindSideProView.swift
//  FlightComputer
//
//  Created by ali cihan on 11.03.2025.
//

import SwiftUI

struct WindSideProView: View {
    @State var vm = WindSideProViewModel()

    @State var lineAngle: Angle = Angle(degrees: 10)
    
    @State var scale: CGFloat = 1
    @State var gestureScale: CGFloat = 1
    var totalScale: CGFloat { scale * gestureScale }
    
    //Wheel and mark rotation angle
    @State var rotation: Angle = Angle(degrees: 0)
    
    //Wheel offset
    @State var verticalOffset: CGFloat = 0
    
    //Wind speed mark
    @State var windDirection: Angle = Angle(degrees: 0)
    var windMarkDegree: Double {
        vm.calculateWindMarkDegree(windDirection: windDirection.degrees, rotation: rotation.degrees)
    }
    @State var markOffset: CGFloat = 0
    
    @State var pan: CGOffset = .zero
    @State var gesturePan: CGOffset = .zero
    var totalPan: CGOffset { pan + gesturePan }
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .center) {
            windSideComponents
            panelControlButtons
        }
        .safeAreaInset(edge: .bottom, content: {
            Color.clear
                .frame(height: 25)
        })
        .background(Constants.bgColor)
//        .animation(.easeInOut, value: verticalOffset)
        .simultaneousGesture(
            PanGesture(gesturePan: $gesturePan, pan: $pan)
        )
        .simultaneousGesture(
            MagnifyGestureHandler(gestureScale: $gestureScale, scale: $scale)
        )
        .sheet(isPresented: $vm.isControllerShowing) {
            controllerView
                .padding()
                .presentationBackground(Constants.sheetBg)
                .presentationDetents([.medium, .fraction(0.4)])
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
    WindSideProView()
}
