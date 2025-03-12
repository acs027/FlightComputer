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
                    if vm.wCACalculator.trueAirSpeed > 0 {
                        let value = vm.wCACalculator.trueAirSpeed
                        debugPrint(value)
                        verticalOffset = vm.calculateVerticalOffset(value: value)
                    }
                    if markOffset != 0 {
                        debugPrint("\(markOffset)  markoffset")
                        markOffset = vm.calculateMarkOffset(value: vm.wCACalculator.windSpeed)
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
    
    
    func downMethodCorrection() {
        if let wca = vm.wCACalculator.windCorrectionAngle,
           wca != 0,
           !wca.isNaN
        {
            withAnimation {
                rotation.degrees = (vm.wCACalculator.trueCourse + wca + 360).truncatingRemainder(dividingBy: 360)
            }
        }
        
    }
}
