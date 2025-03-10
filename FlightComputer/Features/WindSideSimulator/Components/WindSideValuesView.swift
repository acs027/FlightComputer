//
//  WindSideValuesView.swift
//  FlightComputer
//
//  Created by ali cihan on 7.03.2025.
//

import SwiftUI

extension WindSideView {
    var values: some View {
        ZStack(alignment: .topLeading) {
            Color.clear
            VStack(alignment: .leading) {
                ForEach(vm.results, id: \.label) { result in
                    ResultTextView(label: result.label, value: result.value, valueType: result.type)
                }
                Text("Set TAS again!")
                    .background(.red)
                    .opacity(vm.isValuesWarningShowing ? 1 : 0)
                    
            }
        }
        .opacity(vm.isValuesShowing ? 1 : 0)
            .padding()
    }
}
