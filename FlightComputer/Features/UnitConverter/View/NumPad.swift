//
//  NumPad.swift
//  FlightComputer
//
//  Created by ali cihan on 18.02.2025.
//

import SwiftUI

struct NumPad: View {
    @State private var inputText: String = ""
    @Binding var value: Double

    let gridItems = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]

    let numbers = [
        "1", "2", "3",
        "4", "5", "6",
        "7", "8", "9",
        ".", "0", "⌫"
    ]
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 0
        formatter.usesGroupingSeparator = false
        return formatter
    }()

    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 10) {
            ForEach(numbers, id: \.self) { number in
                Button(action: {
                    handleInput(number)
                }) {
                    Text(number)
                        .font(.title)
                        .frame(width: 50, height: 50)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                .disabled(number.isEmpty)
            }
        }
        .padding()
        .onChange(of: inputText) { oldValue, newValue in
            if let doubleValue = Double(newValue), !newValue.hasSuffix(".") {
                self.value = doubleValue
            } else if newValue.isEmpty {
                self.value = 0
            }
        }
        .onChange(of: value) { oldValue, newValue in
            if inputText != String(newValue) {
                self.inputText = numberFormatter.string(from: newValue as NSNumber) ?? "0"
            }
        }
    }

    private func handleInput(_ value: String) {
        if value == "⌫" {
            if !inputText.isEmpty {
                if inputText.count > 2 {
                    let index = inputText.index(inputText.endIndex, offsetBy: -2)
                    let char = inputText[index]
                    if char == "." {
                        inputText = String(inputText.dropLast(2))
                    } else {
                        inputText.removeLast()
                    }
                } else {
                    inputText.removeLast()
                }
            }
        } else if value == "." {
            if !inputText.contains(".") {
                inputText.append(value)
            }
        } else {
            inputText.append(value)
        }
    }
}

#Preview {
    @Previewable @State var value: Double = 14.5
    NumPad(value: $value)
}

