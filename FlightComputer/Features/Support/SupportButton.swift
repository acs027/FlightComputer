//
//  SupportButton.swift
//  FlightComputer
//
//  Created by ali cihan on 6.01.2026.
//

import SwiftUI

struct SupportButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    

    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .bold))
                
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .bold))
                    .opacity(0.5)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(color.gradient) // Adds a subtle modern iOS shimmer
            )
            .shadow(color: color.opacity(0.3), radius: 8, x: 0, y: 4)
        }
        .buttonStyle(PressableButtonStyle()) // Custom press effect
    }
}

// Custom style to make the button shrink slightly when tapped
struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}
