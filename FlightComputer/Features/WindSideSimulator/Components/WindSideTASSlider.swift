//
//  WindSideTASSlider.swift
//  FlightComputer
//
//  Created by ali cihan on 20.02.2025.
//

import SwiftUI

struct WindSideTASSlider: View {
    let vm: WindSideViewModel
    @Binding var verticalOffset: CGFloat
    let speedValue: CGFloat
    
    var calculatedSpeedValue: CGFloat? {
        speedValue + (vm.wCACalculator.headWind ?? 0)
    }
    
    var body: some View {
        verticalSlider
    }
    
    var verticalSlider: some View {
        VStack{
            Slider(value: $verticalOffset, in: vm.verticalRange, step: vm.unitHeight)
                .rotationEffect(.degrees(180))
            Stepper {
                HStack {
                    Text("True Air Speed: ")
                    TextField("Enter a number", text: verticalFormattedBinding)
                }
            } onIncrement: {
                verticalOffset = vm.verticalStepperIncrement(value: verticalOffset)
            } onDecrement: {
                verticalOffset = vm.verticalStepperDecrement(value: verticalOffset)
            }
        }
    }
    
    private var verticalFormattedBinding: Binding<String> {
        Binding(
            get: { String(format: "%.0f", (calculatedSpeedValue ?? 0)) },
            set: { newValue in
                if let value = Double(newValue),
                   vm.isVerticalOffsetInRange(value: value){
                    verticalOffset = vm.calculateVerticalOffset(value: value)
                }
            }
        )
    }
}

#Preview {
    @Previewable @State var vm = WindSideViewModel()
    @Previewable @State var verticalOffset: CGFloat = .zero
    @Previewable var speedValue: CGFloat = .zero
    WindSideTASSlider(vm: vm, verticalOffset: $verticalOffset, speedValue: speedValue)
}
