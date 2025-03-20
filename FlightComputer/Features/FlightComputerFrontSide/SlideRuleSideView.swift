//
//  SlideRuleSideView.swift
//  FlightComputer
//
//  Created by ali cihan on 20.03.2025.
//

import SwiftUI

struct SlideRuleSideView: View {
    @State var vm = WindSideProViewModel()

    @State var scale: CGFloat = 1
    @State var gestureScale: CGFloat = 1
    var totalScale: CGFloat { scale * gestureScale }
    
    @State var pan: CGOffset = .zero
    @State var gesturePan: CGOffset = .zero
    var totalPan: CGOffset { pan + gesturePan }
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Group {
                baseLayer
                frontLayer
            }
            .offset(totalPan)
            .scaleEffect(totalScale)
            slider
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Constants.bgColor)
        .simultaneousGesture(
            PanGesture(gesturePan: $gesturePan, pan: $pan)
        )
        .simultaneousGesture(
            MagnifyGestureHandler(gestureScale: $gestureScale, scale: $scale)
        )
        .onAppear {
            DispatchQueue.main.async {
                scale = vm.scaleValueFitTheView()
            }
        }
    }
    
    var baseLayer: some View {
        Image("flightcomputerouter")
            .resizable()
            .scaledToFit()
    }
    
    var frontLayer: some View {
        Image("flightcomputerinner")
            .resizable()
            .scaledToFit()
            .rotationEffect(Angle(degrees: vm.rotationDegree), anchor: UnitPoint(x: 0.5, y: 0.5))
    }
    
    var slider: some View {
        WindSideAngleSlider(rotation: $vm.rotationDegree)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Constants.sheetBg)
            )
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
    
    //MARK: Constants
    struct Constants {
        static let bgColor: Color = Color(.systemGroupedBackground)
        static let sheetBg: Color = Color(.systemGroupedBackground)
        static let centerButtonBgColor: Color = Color(.tertiarySystemBackground)
    }
    
    func centerTheView() {
        withAnimation {
            pan = .zero
        }
    }
}

#Preview {
    SlideRuleSideView()
}
