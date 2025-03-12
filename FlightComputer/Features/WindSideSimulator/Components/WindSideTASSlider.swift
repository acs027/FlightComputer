//
//  WindSideTASSlider.swift
//  FlightComputer
//
//  Created by ali cihan on 20.02.2025.
//

import SwiftUI

struct WindSideTASSlider<ViewModel: WindSideViewModelProtocol>: View {
    let vm: ViewModel
    @Binding var verticalOffset: CGFloat
    let speedValue: CGFloat
    var title: String = "True Air Speed"
    
    var body: some View {
        verticalSlider
    }
    
    var verticalSlider: some View {
        VStack{
            Slider(value: $verticalOffset, in: vm.verticalRange, step: vm.unitHeight)
                .rotationEffect(.degrees(180))
            Stepper {
                HStack {
                    Text("\(title): ")
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
            get: { String(format: "%.0f", (speedValue)) },
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
