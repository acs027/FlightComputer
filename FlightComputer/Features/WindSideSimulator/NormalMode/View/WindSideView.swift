//
//  WindSideView.swift
//  FlightComputer
//
//  Created by ali cihan on 15.02.2025.
//

import SwiftUI

struct WindSideView: View {
    @State var vm = WindSideViewModel()
    
    @State var height: Double = 0
    
    @State var scale: CGFloat = 1
    @State var gestureScale: CGFloat = 1
    var totalScale: CGFloat { scale * gestureScale }
    
    @State var pan: CGOffset = .zero
    @State var gesturePan: CGOffset = .zero
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
        .onChange(of: vm.calculationStepType) { oldValue, newValue in
            if oldValue != newValue {
                reset()
                scale = vm.scaleValueFitTheView()
            }
        }
        .onChange(of: vm.verticalOffset) { oldValue, newValue in
            centerTheView()
        }
        .onChange(of: vm.isHighSpeed) { oldValue, newValue in
            reset()
        }
        .onAppear {
            DispatchQueue.main.async {
                scale = vm.scaleValueFitTheView()
            }
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
        static let centerButtonBgColor: Color = Color(.tertiarySystemBackground)
    }
    
    func reset() {
        withAnimation {
            vm.reset()
        }
    }
}

#Preview {
    WindSideView()
}
