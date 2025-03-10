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
//                lineOnAngle
            }
//            .simultaneousGesture(trueIndexGesture)
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
                .onChange(of: geometry.size) { oldValue, newValue in
                    vm.referenceHeight = geometry.size.height
                    if vm.wCACalculator.trueAirSpeed > 0 {
                        let value = vm.wCACalculator.trueAirSpeed
                        print(value)
                        verticalOffset = vm.calculateVerticalOffset(value: value)
                    }
                    if markOffset != 0 {
                        print("\(markOffset)  markoffset")
                        markOffset = vm.calculateMarkOffset(value: vm.wCACalculator.windSpeed)
                    }
                }
        }
    }
    
    var windSideStator: some View {
        Image("windsiderotorouter")
            .resizable()
            .scaledToFit()
            .offset(y: vm.verticalOffsetByMode(vertical: verticalOffset))
    }
    
    var windSideRotor: some View {
        Image("windsiderotor")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .offset(
                x: sin(-rotation.radians) * vm.verticalOffsetByMode(vertical: verticalOffset) ,
                    y: cos(-rotation.radians) * vm.verticalOffsetByMode(vertical: verticalOffset)
            )
            .rotationEffect(-rotation)
    }
    
    var markOnRotor: some View {
        Group {
            Circle()
                .frame(width: 10)
                .offset(y: vm.markOffsetByMode(mark: markOffset))
                .rotationEffect(Angle(degrees: vm.markDegree(rotation: rotation.degrees)))
        }
        .offset(y: vm.verticalOffsetByMode(vertical: verticalOffset))
    }
    
    var lineOnRotor: some View {
        Group {
            Rectangle()
                .frame(width: 1, height: abs(markOffset))
                .offset(y: vm.markOffsetByMode(mark: markOffset) / 2)
                .rotationEffect(Angle(degrees: vm.markDegree(rotation: rotation.degrees)))
        }
        .offset(y: vm.verticalOffsetByMode(vertical: verticalOffset))
    }
    
    
//    var lineOnAngle: some View {
//        Group {
//            Rectangle()
//                .frame(width: 3, height: abs(260 * vm.unitHeight))
//                .rotationEffect(lineAngle, anchor: .bottom)
//                .offset(
//                    x: vm.angleLineOffset(angle: lineAngle.radians).x,
//                    y: vm.angleLineOffset(angle: lineAngle.radians).y
//                )
//                .mask {
//                    Circle()
//                        .frame(width: vm.unitHeight * 104)
//                }
//        }
//        .rotationEffect(-rotation)
//        .offset(y: verticalOffset)
//    }
}
