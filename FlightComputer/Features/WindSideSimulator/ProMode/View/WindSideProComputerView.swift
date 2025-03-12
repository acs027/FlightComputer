//
//  WindSideProComputerView.swift
//  FlightComputer
//
//  Created by ali cihan on 11.03.2025.
//

import SwiftUI

extension WindSideProView {
    //MARK: Main components
    var windSideComponents: some View {
        Group{
            windSideBackground
            Group{
                windSideStator
                windSideRotor
                markOnRotor
                lineOnRotor
                staticLineOnAngle
                dynamicLineOnAngle
            }
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
                    vm.referenceHeight = newValue.height
                    debugPrint(geometry.size.height)
                    verticalOffset *= newValue.height/oldValue.height
                    if markOffset != 0 {
                        debugPrint("\(markOffset)  markoffset")
                        markOffset *= newValue.height/oldValue.height
                    }
                }
                .onAppear {
                    let height = geometry.size.height
                    if vm.referenceHeight != height {
                        vm.referenceHeight = geometry.size.height
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
            //                .rotationEffect(Angle(degrees: vm.markDegree(rotation: rotation.degrees)))
                .rotationEffect(Angle(degrees: windMarkDegree))
        }
        .offset(y: vm.verticalOffsetByMode(vertical: verticalOffset))
    }
    
    var lineOnRotor: some View {
        Group {
            Rectangle()
                .frame(width: 1, height: abs(markOffset))
                .offset(y: vm.markOffsetByMode(mark: markOffset) / 2)
                .rotationEffect(Angle(degrees: windMarkDegree))
        }
        .offset(y: vm.verticalOffsetByMode(vertical: verticalOffset))
    }
    
    
    var dynamicLineOnAngle: some View {
        Rectangle()
            .frame(width: 3, height: abs(260 * vm.unitHeight))
            .opacity(0)
//            .offset(y: -vm.unitHeight * 2.5)
            .foregroundStyle(.blue)
            .overlay {
                lineOnAngle
                    .foregroundStyle(.green)
            }
            .rotationEffect(Angle(degrees: vm.calculateLineDegree(rotation: rotation.degrees)), anchor: UnitPoint(x: 0.5, y: (130 + verticalOffset / vm.unitHeight) / 260))
//            .rotationEffect(-rotation, anchor: UnitPoint(x: 0.5, y: (130 + verticalOffset / vm.unitHeight) / 260))
            .mask {
                lineOnAngleMask
            }
            .opacity(vm.islineShowing ? 1 : 0)
    }
    
    var staticLineOnAngle: some View {
        Rectangle()
            .frame(width: 3, height: abs(260 * vm.unitHeight))
            .opacity(0)
//            .offset(y: -vm.unitHeight * 2.5)
            .foregroundStyle(.blue)
            .overlay {
                lineOnAngle
                    .foregroundStyle(.blue)
            }
            .mask {
                lineOnAngleMask
            }
            .opacity(vm.islineShowing ? 1 : 0)
    }
    
    private var lineOnAngleMask: some View {
        Circle()
            .frame(width: vm.unitHeight * 100)
            .offset(
                x: sin(-rotation.radians) * vm.verticalOffsetByMode(vertical: verticalOffset),
                y: cos(-rotation.radians) * vm.verticalOffsetByMode(vertical: verticalOffset)
            )
            .rotationEffect(-rotation)
    }
    
    private var lineOnAngle: some View {
        Rectangle()
            .frame(width: 2, height: abs(260 * vm.unitHeight))
//            .offset(y: -vm.unitHeight * 2.5)
            .rotationEffect(lineAngle, anchor: .bottom)
            .offset(
                x: vm.angleLineOffset(angle: lineAngle.radians).x,
                y: vm.angleLineOffset(angle: lineAngle.radians).y
            )
    }
}
