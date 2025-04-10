//
//  ControllerButtons.swift
//  FlightComputer
//
//  Created by ali cihan on 18.03.2025.
//

import SwiftUI

struct ControllerButton: View {
    let function: () -> Void
    let color: Color
    let fillColor: Color
    let systemImage: String
    let title: String
    var body: some View {
            Button {
                function()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: systemImage)
                        .font(.system(size: 14, weight: .bold))
                    
                    Text(title)
                        .font(.system(size: 15, weight: .semibold))
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 20)
                .foregroundStyle(color)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(fillColor)
                        
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    }
                )
                .shadow(color: fillColor.opacity(0.3), radius: 4, x: 0, y: 2)
            }
            .buttonStyle(PressableButtonStyle())
    }
    
    // Custom Button Style for Consistent Press Animation
    struct PressableButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .scaleEffect(configuration.isPressed ? 0.96 : 1)
                .opacity(configuration.isPressed ? 0.9 : 1)
                .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
        }
    }
}

