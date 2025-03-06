//
//  IASCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import SwiftUI

struct IASCalculatorView: View {
    @State var vm = IASCalculatorViewModel()
    
    var body: some View {
        ScrollView {
            Picker("IAS Calculator",selection: $vm.calculator) {
                ForEach(IASCalculatorViewModel.Calculator.allCases, id:\.self) { calculator in
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
            IASFromAltimeterCalculatorView(vm: vm)
        case .pressure:
            IASFromPressureAltCalculatorView(vm: vm)
        }
    }
}

#Preview {
//    @Previewable @State var vm = IASCalculatorViewModel()
    IASCalculatorView()
}
