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
        WindBaseLayer(geometryChangeHandler: vm.geometryChangeHandler, backgroundOnAppearHandler: vm.backgroundOnAppearHandler, isHighSpeed: vm.isHighSpeed)
    }
    
    var windSideStator: some View {
        WindStatorDisc(verticalOffset: vm.verticalOffset, componentWidth: $vm.componentWidth)
    }
    
    var windSideRotor: some View {
        WindRotorDisc(rotation: vm.rotationDegree, verticalOffset: vm.verticalOffset)
            .onTapGesture { location in
                if vm.isEditableForDot {
                    vm.putDot(at: vm.rotationDegree, where: location)
                }
            }
            .overlay {
                ForEach(vm.dots, id:\.id) { dot in
                    Circle()
                        .foregroundStyle(Color(UIColor(red: dot.color.0, green: dot.color.1, blue: dot.color.2, alpha: dot.color.3)))
                        .frame(width: 5)
                        .position(dot.location)
                        .rotationEffect(Angle(degrees: dot.degree - vm.rotationDegree))
                }
            }
    }
    
    var markOnRotor: some View {
        WindMarkOnRotor(verticalOffset: vm.verticalOffset, windMarkOffset: vm.windMarkOffsetByMode(), windMarkDegree: vm.windMarkDegree)
    }
    
    var lineOnRotor: some View {
        LineToWindMarkOnRotor(verticalOffset: vm.verticalOffset, windMarkOffset: vm.windMarkOffsetByMode(), windMarkDegree: vm.windMarkDegree)
    }
    
    
    var dynamicLineOnAngle: some View {
//        DynamicDriftAngleLine(vm: vm)
        DriftAngleLine(vm: vm, isDynamic: true)
//        DynamicDriftAngleLine(vm: vm)
    }
    
    var staticLineOnAngle: some View {
        DriftAngleLine(vm: vm, isDynamic: false)
    }
}
