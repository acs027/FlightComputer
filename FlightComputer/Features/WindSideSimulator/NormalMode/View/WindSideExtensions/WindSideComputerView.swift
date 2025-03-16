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
            .rotationEffect(Angle(degrees: -vm.rotation), anchor: UnitPoint(x: 0.5, y: 0.5))
            .offset(y: vm.verticalOffset)
    }
    
    var markOnRotor: some View {
        Group {
            Circle()
                .frame(width: 10)
                .offset(y: -vm.windMarkOffset)
                .rotationEffect(Angle(degrees: vm.windMarkDegree()))
        }
        .offset(y: vm.verticalOffset)
    }
    
    var lineOnRotor: some View {
        Group {
            Rectangle()
                .frame(width: 1, height: abs(vm.windMarkOffset))
                .offset(y: -vm.windMarkOffset / 2)
                .rotationEffect(Angle(degrees: vm.windMarkDegree()))
        }
        .offset(y: vm.verticalOffset )
    }
}
