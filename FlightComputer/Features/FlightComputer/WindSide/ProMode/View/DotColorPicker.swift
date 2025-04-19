//
//  DotMenu.swift
//  FlightComputer
//
//  Created by ali cihan on 18.04.2025.
//

import SwiftUI

import UIKit

struct DotColorPicker: View {
    var dot: Dot
    let function: (CGFloat, CGFloat, CGFloat, CGFloat) -> Void

    @State private var showPicker = false
    @State private var selectedColor: UIColor

    init(dot: Dot, function: @escaping (CGFloat, CGFloat, CGFloat, CGFloat) -> Void) {
        self.dot = dot
        self.function = function
        _selectedColor = State(initialValue: UIColor(red: dot.color.0, green: dot.color.1, blue: dot.color.2, alpha: dot.color.3))
    }

    var body: some View {
        Circle()
            .fill(Color(selectedColor))
            .frame(width: 40, height: 40)
            .shadow(radius: 3)
            .overlay {
                Circle()
                    .stroke(lineWidth: 3)
                    .foregroundStyle(.primary)
            }
            .onTapGesture {
                showPicker = true
            }
            .fullScreenCover(isPresented: $showPicker) {
                UIKitColorPicker(
                    initialColor: selectedColor,
                    onColorSelected: { color in
                        selectedColor = color
                        var red: CGFloat = 0
                        var green: CGFloat = 0
                        var blue: CGFloat = 0
                        var alpha: CGFloat = 0
                        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                        function(red, green, blue, alpha)
                        showPicker = false // Dismiss after picking
                    },
                    onCancel: {
                        showPicker = false
                    }
                )
            }
    }
}

struct UIKitColorPicker: UIViewControllerRepresentable {
    var initialColor: UIColor
    var onColorSelected: (UIColor) -> Void
    var onCancel: () -> Void

    func makeUIViewController(context: Context) -> UIColorPickerViewController {
        let picker = UIColorPickerViewController()
        picker.selectedColor = initialColor
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIColorPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onColorSelected: onColorSelected, onCancel: onCancel)
    }

    class Coordinator: NSObject, UIColorPickerViewControllerDelegate {
        var onColorSelected: (UIColor) -> Void
        var onCancel: () -> Void

        init(onColorSelected: @escaping (UIColor) -> Void, onCancel: @escaping () -> Void) {
            self.onColorSelected = onColorSelected
            self.onCancel = onCancel
        }

        func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
            onCancel()
        }

        func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            onColorSelected(viewController.selectedColor)
        }
    }
}

//struct DotColorPicker: View {
//    var dot: Dot
//    let function: (CGFloat,CGFloat,CGFloat,CGFloat) -> Void
//    
//    var body: some View {
//        ColorPicker("", selection: colorBinding)
//    }
//    
//    var colorBinding: Binding<Color> {
//        Binding<Color>(
//            get: {
//                Color(UIColor(red: dot.color.0, green: dot.color.1, blue: dot.color.2, alpha: dot.color.3))
//            },
//            set: { newColor in
//                let color = newColor.getRGBAValues()
//                function(color.0,color.1,color.2,color.3)
//            }
//        )
//    }
//    
//}

extension Color {
    func getRGBAValues() -> (CGFloat,CGFloat,CGFloat,CGFloat) {
        let uiColor = UIColor(self)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        
        guard uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) else {
            // You can handle the failure here as you want
            return (1, 1, 1, 1)
        }
        return (r, g, b, a)
    }
}

//#Preview {
//    DotMenu()
//}
