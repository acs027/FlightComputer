//
//  TrueAirSpeedCalculator.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import SwiftUI

struct TASCalculatorView: View {
    @State var vm = TASCalculatorViewModel()
    
    var body: some View {
        ScrollView {
            Picker("TAS Calculator",selection: $vm.calculator) {
                ForEach(TASCalculatorViewModel.Calculator.allCases, id:\.self) { calculator in
                    Text(calculator.rawValue)
                }
            }
            .pickerStyle(.segmented)
            calculators
        }
    }
    
    @ViewBuilder
    var calculators: some View {
        switch vm.calculator {
        case .altimeter:
            TASFromAltimeterCalculatorView(vm: vm)
        case .pressure:
            TASFromPressureAltCalculatorView(vm: vm)
        }
    }
}

#Preview {
//    @Previewable @State var vm = TASCalculatorViewModel()
    TASCalculatorView()
}
