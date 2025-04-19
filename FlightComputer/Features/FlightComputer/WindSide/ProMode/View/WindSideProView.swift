//
//  WindSideProView.swift
//  FlightComputer
//
//  Created by ali cihan on 11.03.2025.
//

import SwiftUI

struct WindSideProView: View {
    @State var vm = WindSideProViewModel()

    @State var scale: CGFloat = 1
    @State var gestureScale: CGFloat = 1
    var totalScale: CGFloat { scale * gestureScale }
    
    @State var pan: CGOffset = .zero
    @State var gesturePan: CGOffset = .zero
    var totalPan: CGOffset { pan + gesturePan }
    
    @State var color: Color = .black
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .center) {
            windSideComponents
            panelControlButtons
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
                .presentationDetents([.fraction(0.4), .medium, .large])
        }
        .onAppear {
            DispatchQueue.main.async {
                scale = vm.scaleValueFitTheView()
            }
        }
        .onChange(of: vm.verticalOffset) { oldValue, newValue in
            centerView()
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
    
    func centerTheView() {
        withAnimation {
            pan.height = -vm.verticalOffset
            pan.width = .zero
        }
    }
}

#Preview {
    WindSideProView()
}
