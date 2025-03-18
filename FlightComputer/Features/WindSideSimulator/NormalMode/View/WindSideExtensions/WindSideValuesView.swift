//
//  WindSideValuesView.swift
//  FlightComputer
//
//  Created by ali cihan on 7.03.2025.
//

import SwiftUI

extension WindSideView {
    var values: some View {
        ZStack(alignment: .leading) {
            Color.clear
            VStack(alignment: .leading) {
                ForEach(vm.results, id: \.label) { result in
                    ResultTextView(label: result.label, value: result.value, valueType: result.type)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.primary.opacity(0.8))
                    .shadow(color: .black, radius: 0.5)
                    
        
            )
        }
        .opacity(vm.isValuesShowing ? 1 : 0)
        .padding()
        .safeAreaInset(edge: .top) {
            Color.clear
                .frame(height: 100)
        }
        .transition(.move(edge: .leading))
    }
}
