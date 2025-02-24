//
//  WCATextField.swift
//  FlightComputer
//
//  Created by ali cihan on 20.02.2025.
//

import SwiftUI

struct WCATextField: View {
    let title: String
    @Binding var value: Double
    let placeHolder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
            TextField(placeHolder, value: $value, format: .number)
                .textFieldStyle(CustomTextFieldStyle())
        }
        .foregroundStyle(Constants.textColor)
        .padding(10)
        .background(Constants.bgColor)
        .cornerRadius(10)
    }
}

//MARK: Constants
private struct Constants {
    static let textColor: Color = .primary
    static let bgColor: Color = Color(.secondarySystemBackground)
    static let textFieldColor: Color = Color(.systemBackground)
}

private struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
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
    WCATextField(title: "Wind Speed", value: $value, placeHolder: "Enter wind speed")
}
