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
            ZStack {
                Image("windsidebackground")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width)
                    .onChange(of: geometry.size) { oldValue, newValue in
                        vm.geometryChangeHandler(newValue: newValue, oldValue: oldValue)
                    }
                    .onAppear {
                        vm.backgroundOnAppearHandler(size: geometry.size)
                    }
                Image("windsidehighspeedoverlay")
                    .resizable()
                    .scaledToFit()
                    .opacity(vm.isHighSpeed ? 1 : 0)
            }
        }
    }
    
    var windSideStator: some View {
        Image("windsiderotorouter")
            .resizable()
            .scaledToFit()
            .offset(y: vm.verticalOffset)
            .overlay {
                GeometryReader {
                    geometry in
                    Color.clear
                        .onChange(of: geometry.size.width) { oldValue, newValue in
                            vm.componentWidth = geometry.size.width
                        }
                        .onAppear{
                            vm.componentWidth = geometry.size.width
                        }
                }
            }
    }
    
    var windSideRotor: some View {
        Image("windsiderotor")
            .resizable()
            .aspectRatio(contentMode: .fit)
//            .offset(
//                x: sin(-Angle(degrees: vm.rotationDegree).radians) * vm.verticalOffset ,
//                y: cos(-Angle(degrees: vm.rotationDegree).radians) * vm.verticalOffset
//            )
            .rotationEffect(-Angle(degrees: vm.rotationDegree), anchor: UnitPoint(x: 0.5, y: 0.5))
            .offset(y: vm.verticalOffset)
    }
    
    var markOnRotor: some View {
        Group {
            Circle()
                .frame(width: 10)
                .offset(y: vm.windMarkOffsetByMode(mark: vm.windMarkOffset))
            //                .rotationEffect(Angle(degrees: vm.markDegree(rotation: rotation.degrees)))
                .rotationEffect(Angle(degrees: vm.windMarkDegree()))
        }
        .offset(y: vm.verticalOffset)
    }
    
    var lineOnRotor: some View {
        Group {
            Rectangle()
                .frame(width: 1, height: abs(vm.windMarkOffset))
                .offset(y: vm.windMarkOffsetByMode(mark: vm.windMarkOffset) / 2)
                .rotationEffect(Angle(degrees: vm.windMarkDegree()))
        }
        .offset(y: vm.verticalOffset)
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
            .rotationEffect(Angle(degrees: vm.lineDegree(rotation: vm.rotationDegree)), anchor: UnitPoint(x: 0.5, y: (130 + vm.verticalOffset / vm.unitHeight) / 260))
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
                x: sin(-Angle(degrees: vm.rotationDegree).radians) * vm.verticalOffset,
                y: cos(-Angle(degrees: vm.rotationDegree).radians) * vm.verticalOffset
            )
            .rotationEffect(-Angle(degrees: vm.rotationDegree))
    }
    
    private var lineOnAngle: some View {
        Rectangle()
            .frame(width: 2, height: abs(260 * vm.unitHeight))
//            .offset(y: -vm.unitHeight * 2.5)
            .rotationEffect(Angle(degrees: vm.lineAngle), anchor: .bottom)
            .offset(
                x: vm.angleLineOffset(angle: Angle(degrees: vm.lineAngle).radians).x,
                y: vm.angleLineOffset(angle: Angle(degrees: vm.lineAngle).radians).y
            )
    }
}
