//
//  NumPad.swift
//  FlightComputer
//
//  Created by ali cihan on 18.02.2025.
//

import SwiftUI

struct NumPad: View {
    @Binding var inputText: String
    @Binding var value: Double
    let swapFunction: () -> Void

    let gridItems = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]

    let numbers = [
        "1", "2", "3","⥮",
        "4", "5", "6","C",
        "7", "8", "9","",
        "00", "0", ".","⌫"
    ]
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 5) {
            ForEach(numbers, id: \.self) { number in
                Button(action: {
                    handleInput(number)
                }) {
                    Text(number)
                        .font(.title)
                        .frame(width: 45, height: 45)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                .disabled(number.isEmpty)
            }
        }
        .padding()
        .onChange(of: inputText) { oldValue, newValue in
            if let doubleValue = Double(newValue) {
                self.value = doubleValue
            }
        }
    }

    private func handleInput(_ value: String) {
        if value == "⥮" {
            swapFunction()
            return
        }
        else if value == "C" {
            inputText = "0"
            return
        }
        else if value == "⌫" {
            if inputText.isEmpty {
                return
            }
            inputText.removeLast()
        }
        else if value == "." {
            if !inputText.contains(".") && !inputText.isEmpty {
                inputText.append(value)
            }
        } else {
            if inputText == "0" {
                inputText = value
            } else {
                inputText.append(value)
            }
        }
    }
}

#Preview {
    @Previewable @State var value: Double = 14.5
    @Previewable @State var inputText: String = ""
    NumPad(inputText: $inputText, value: $value, swapFunction: { })
}

