//
//  WCATextField.swift
//  FlightComputer
//
//  Created by ali cihan on 20.02.2025.
//

import SwiftUI

struct CustomTextFieldView: View {
    let title: String
    @Binding var value: Double
    let placeHolder: String
    var unit: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
            HStack {
                TextField(placeHolder, value: $value, format: .number)
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
}

//MARK: Constants
private struct Constants {
    static let bgColor: Color = Color("textfieldframebg")
    static let textFieldColor: Color = Color("textfieldbg")
}

private struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .keyboardType(.decimalPad)
            .padding(10)
            .background(Constants.textFieldColor)
            .cornerRadius(8)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            
            }
                
    }
}

#Preview {
    @Previewable @State var value: Double = 240
    CustomTextFieldView(title: "Wind Speed", value: $value, placeHolder: "Enter wind speed")
}
