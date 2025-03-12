//
//  WindSideWindSpeedSlider.swift
//  FlightComputer
//
//  Created by ali cihan on 20.02.2025.
//

import SwiftUI

struct WindSideWindSpeedSlider<ViewModel: WindSideViewModelProtocol>: View {
    let vm: ViewModel
    @Binding var markOffset: CGFloat
    let markValue: CGFloat
    
    var body: some View {
        markSlider
    }
    //MARK: Sliders
    var markSlider: some View {
        VStack{
            Slider(value: $markOffset, in: vm.markRange, step: vm.unitHeight)
                .rotationEffect(.degrees(180))
            Stepper {
                HStack {
                    Text("Wind speed: ")
                    TextField("Enter a number", text: markFormattedBinding)
                }
            } onIncrement: {
                markOffset = vm.markStepperIncrement(value: markOffset)
            } onDecrement: {
                markOffset = vm.markStepperDecrement(value: markOffset)
            }
        }
    }
    
    private var markFormattedBinding: Binding<String> {
        Binding(
            get: { String(format: "%.2f", abs(markValue)) },
            set: { newValue in
                if let value = Double(newValue),
                   vm.isMarkInRange(value: value)
                {
                    markOffset = vm.calculateMarkOffset(value: value)
                }
            }
        )
    }
}

#Preview {
    @Previewable @State var vm = WindSideViewModel()
    @Previewable @State var markOffset: CGFloat = .zero
    @Previewable var markValue: CGFloat = .zero
    WindSideWindSpeedSlider(vm: vm, markOffset: $markOffset, markValue: markValue)
}
