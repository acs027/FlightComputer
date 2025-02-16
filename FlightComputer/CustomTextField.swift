//
//  CustomTextField.swift
//  FlightComputer
//
//  Created by ali cihan on 13.02.2025.
//

import SwiftUI


struct CustomTextField<U: UnitType>: View {
    let unit: U
    @FocusState var focused: U?
    @Binding var value: Double
    @Binding var currentUnit: U
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 0
        return formatter
    }()
    
    private var convertedValue: Double {
        currentUnit.convert(value: value, to: unit)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .frame(height: 36)
            TextField("Value", value: $value, formatter: numberFormatter)
                .padding(5)
                .focused($focused, equals: unit)
                .opacity(currentUnit == unit ? 1 : 0)
            
            Text(numberFormatter.string(from: convertedValue as NSNumber) ?? "err")
                .padding(.vertical, 8)
                .padding(.horizontal, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(RoundedRectangle(cornerRadius: 10))
                .opacity(currentUnit == unit ? 0 : 1)
                .onTapGesture {
                    self.value = currentUnit.convert(value: value, to: unit)
                    self.focused = unit
                    self.currentUnit = unit
                }
            Text("\(unit.symbol)")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
        }
    }
}
