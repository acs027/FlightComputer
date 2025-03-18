//
//  CircleButton.swift
//  FlightComputer
//
//  Created by ali cihan on 12.03.2025.
//

import SwiftUI

//struct CircleButton: View {
//    let function: () -> Void
//    let tint: Color
//    var imageSystemName: String?
//    let title: String
//    
//    var body: some View {
//        Button {
//            function()
//        } label: {
//            label
//        }
//    }
//    
//    @ViewBuilder
//    var label: some View {
//        if let image = imageSystemName {
//            Image(systemName: image)
//                .font(.largeTitle)
//                .frame(width: 50, height: 50)
//                .background(
//                    Circle()
//                        .tint(tint)
//                )
//        } else {
//            Text(title)
//                .frame(width: 50, height: 50)
//                .background(
//                    Circle()
//                        .tint(tint)
//                )
//        }
//    }
//}

//#Preview {
//    CircleButton()
//}

import SwiftUI

struct CircleButton: View {
    // MARK: - Properties
    let function: () -> Void
    let tint: Color
    var imageSystemName: String?
    let title: String
    var size: CGFloat = 50
    var strokeWidth: CGFloat = 1.5
    @State private var isPressed = false
    
    // MARK: - Body
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isPressed = false
                }
            }
            function()
        } label: {
            label
                .frame(width: size, height: size)
                .contentShape(Circle())
        }
        .buttonStyle(CircleButtonStyle())
    }
    
    // MARK: - Label View
    @ViewBuilder
    var label: some View {
        ZStack {
            // Background circle with subtle shadow
            Circle()
                .fill(tint)
                .overlay(
                    Circle()
                        .stroke(.white, lineWidth: strokeWidth)
                )
                .shadow(color: .black.opacity(1), radius: 4, x: 0, y: 2)
            
            // Content
            if let image = imageSystemName {
                Image(systemName: image)
                    .font(.system(size: size * 0.4, weight: .medium))
                    .foregroundColor(.primary)
                    .scaleEffect(isPressed ? 0.9 : 1.0)
            } else {
                Text(title)
                    .font(.system(size: size * 0.25, weight: .semibold))
                    .foregroundColor(.primary)
                    .scaleEffect(isPressed ? 0.9 : 1.0)
            }
        }
    }
}

// MARK: - Custom Button Style
struct CircleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(response: 0.2), value: configuration.isPressed)
    }
}

// MARK: - Preview
struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 20) {
            CircleButton(
                function: { print("Button tapped") },
                tint: .white,
                imageSystemName: "airplane",
                title: ""
            )
            
            CircleButton(
                function: { print("Button tapped") },
                tint: .white,
                title: "A"
            )
        }
        .padding(40)
        .background(Color.black)
        .previewLayout(.sizeThatFits)
    }
}
