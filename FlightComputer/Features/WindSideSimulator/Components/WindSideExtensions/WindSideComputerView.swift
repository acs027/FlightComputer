//
//  WindSideComputerView.swift
//  FlightComputer
//
//  Created by ali cihan on 7.03.2025.
//

import SwiftUI

extension WindSideView {
    //MARK: Main components
    var windSideComponents: some View {
        Group{
            windSideBackground
            Group{
                windSideStator
                windSideRotor
                markOnRotor
                lineOnRotor
                lineOnAngle
            }
            // Adding Headwind speed to True Air Speed
//            .offset(y: (vm.wCACalculator.headWind ?? 0) * vm.unitHeight)
        }
        // Enables users to move and scale content for better inspection.
        .offset(totalPan)
        .scaleEffect(totalScale)
    }
    
    var windSideBackground: some View {
        GeometryReader { geometry in
            Image("windsidebackground")
                .resizable()
                .scaledToFit()
                .frame(width: geometry.size.width)
                .preference(key: HeightSizeKey.self, value: geometry.size.height)
        }
        .onPreferenceChange(HeightSizeKey.self) { newValue in
            DispatchQueue.main.async{
                let threshold: CGFloat = 1.0
                if abs(vm.referenceHeight - newValue) > threshold {
                    vm.referenceHeight = newValue
                }
            }
        }
    }
    
    var windSideStator: some View {
        Image("windsiderotorouter")
            .resizable()
            .scaledToFit()
            .offset(y: verticalOffset)
    }
    
    var windSideRotor: some View {
        Image("windsiderotor")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .offset(x: sin(-rotation.radians) * verticalOffset , y: cos(-rotation.radians) * verticalOffset)
            .rotationEffect(-rotation)
    }
    
    var markOnRotor: some View {
        Group {
            Circle()
                .frame(width: 10)
                .offset(y: markOffset)
                .rotationEffect(Angle(degrees: vm.markDegree(rotation: rotation.degrees)))
        }
        .offset(y: verticalOffset)
    }
    
    var lineOnRotor: some View {
        Group {
            Rectangle()
                .frame(width: 1, height: abs(markOffset))
                .offset(y: markOffset / 2)
                .rotationEffect(Angle(degrees: vm.markDegree(rotation: rotation.degrees)))
        }
        .offset(y: verticalOffset)
    }
    
    var lineOnAngle: some View {
        Group {
            Rectangle()
                .frame(width: 3, height: abs(260 * vm.unitHeight))
                .rotationEffect(lineAngle, anchor: .bottom)
                .offset(
                    x: vm.angleLineOffset(angle: lineAngle.radians).x,
                    y: vm.angleLineOffset(angle: lineAngle.radians).y
                )
                .mask {
                    Circle()
                        .frame(width: vm.unitHeight * 104)
                }
        }
        .rotationEffect(-rotation)
        .offset(y: verticalOffset)
    }
    
    struct HeightSizeKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
}
