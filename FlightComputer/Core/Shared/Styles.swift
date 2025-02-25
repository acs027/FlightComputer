//
//  Styles.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

//MARK: Constants
private struct Constants {
    static let textBg: Color = Color("noteditabletextfieldbg")
    static let frameBg: Color = Color("textfieldframebg")
    static let textFieldBg: Color = Color("textfieldbg")
}

struct CustomTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Constants.textBg)
            .cornerRadius(8)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            }
    }
}

struct CustomTextFieldBgStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .padding(10)
        .background(Constants.frameBg)
        .cornerRadius(10)
    }
}

struct CustomTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .padding(10)
            .background(Constants.textFieldBg)
            .cornerRadius(8)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            }
    }
}
