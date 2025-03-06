//
//  TimeTextFieldView.swift
//  FlightComputer
//
//  Created by ali cihan on 6.03.2025.
//

import SwiftUI

struct TimeTextFieldView: View {
    let title: String
    @Binding var value: Double
    let placeHolder: String
    var unit: String?
    
    var formattedValue: String {
        formatTime(value)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
            
            HStack {
                TextField(placeHolder, text: textFieldBinding)
                    .keyboardType(.numbersAndPunctuation)
                    .textFieldStyle(CustomTextFieldStyle())
                
                if let unit = unit {
                    Text(unit)
                }
            }
        }
        .padding()
        .background(Constants.bgColor)
        .cornerRadius(10)
        .padding(.horizontal)
    }
    
    var textFieldBinding: Binding<String> {
        Binding (
            get: {
                formattedValue
            },
            set: { newValue in
                if let parsedValue = parseTime(newValue) {
                    value = parsedValue
                }
            }
        )
    }
    
    /// Converts seconds (Double) to "hh:mm:ss" format
    private func formatTime(_ seconds: Double) -> String {
        let totalSeconds = Int(seconds)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let secondsLeft = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, secondsLeft)
    }
    
    /// Parses "hh:mm:ss" string back to seconds
    private func parseTime(_ timeString: String) -> Double? {
        let components = timeString.split(separator: ":").map { Int($0) }
        guard components.count == 3,
              let hours = components[0],
              let minutes = components[1],
              let seconds = components[2] else { return nil }
        return Double(hours * 3600 + minutes * 60 + seconds)
    }
}

// MARK: Constants
private struct Constants {
    static let bgColor: Color = Color("textfieldframebg")
    static let textFieldColor: Color = Color("textfieldbg")
}

private struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Constants.textFieldColor)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
    }
}

#Preview {
    @Previewable @State var value: Double = 3665 // 1 hour, 1 min, 5 sec
    TimeTextFieldView(title: "Time", value: $value, placeHolder: "hh:mm:ss")
}
