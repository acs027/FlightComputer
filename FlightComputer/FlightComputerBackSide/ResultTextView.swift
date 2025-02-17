//
//  ResultTextView.swift
//  FlightComputer
//
//  Created by ali cihan on 17.02.2025.
//

import SwiftUI

enum ValueType {
    case angle, double
    
    func string(value: Double) -> String {
        switch self {
        case .angle:
            return String(format: "%.0f°", value)
        case .double:
            return String(format: "%.2f", value)
        }
    }
}

struct ResultTextView: View {
    let label: String
    let value: Double
    let valueType: ValueType
    
    
    var body: some View {
        Text("\(label): \(valueType.string(value: value))")
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.blue.gradient)
        )
    }
}

#Preview {
    VStack {
        HStack {
            ResultTextView(label: "Wind Speed", value: 360, valueType: .angle)
            ResultTextView(label: "Wind Speed", value: 360, valueType: .double)
        }
    }
}
