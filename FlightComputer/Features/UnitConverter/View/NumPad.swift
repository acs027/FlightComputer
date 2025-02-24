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
        LazyVGrid(columns: gridItems, spacing: 10) {
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
            if let doubleValue = Double(newValue), !newValue.hasSuffix(".") {
                self.value = doubleValue
            } else if newValue.isEmpty {
                self.value = 0
            }
            print(newValue)
        }
        .onChange(of: value) { oldValue, newValue in
            print(newValue)
            if inputText != String(newValue) {
                self.inputText = FormatterUtils.sharedNumberFormatter.string(from: newValue as NSNumber) ?? "0"
            }
        }
    }

    private func handleInput(_ value: String) {
        if value == "⥮" {
            swapFunction()
            return
        }
        if value == "C" {
            self.value = 0
            return
        }
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
    NumPad(value: $value, swapFunction: { })
}

