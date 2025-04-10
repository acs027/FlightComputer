//
//  ProSideButton.swift
//  FlightComputer
//
//  Created by ali cihan on 12.03.2025.
//

import SwiftUI

struct ProSideButton: View {
    @Binding var condition: Bool
    var function: (() -> Void)?
    
    var body: some View {
        Button {
            if let function = function {
                function()
            } else {
                condition.toggle()
            }
        } label : {
            Image(systemName: condition ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 30, height: 30)
        }
    }
}
