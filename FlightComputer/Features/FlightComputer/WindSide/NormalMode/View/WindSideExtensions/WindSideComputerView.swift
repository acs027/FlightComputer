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
            .offset(y: -vm.unitHeight * 0.5)
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
        WindRotorDisc(rotation: vm.rotation, verticalOffset: vm.verticalOffset)
    }
    
    var markOnRotor: some View {
        WindMarkOnRotor(verticalOffset: vm.verticalOffset, windMarkOffset: vm.windMarkOffset, windMarkDegree: vm.windMarkDegree)
    }
    
    var lineOnRotor: some View {
        LineToWindMarkOnRotor(verticalOffset: vm.verticalOffset, windMarkOffset: vm.windMarkOffset, windMarkDegree: vm.windMarkDegree)
    }
}
