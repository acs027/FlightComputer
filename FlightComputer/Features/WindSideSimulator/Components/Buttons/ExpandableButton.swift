//
//  ExpendableButton.swift
//  FlightComputer
//
//  Created by ali cihan on 17.03.2025.
//

import SwiftUI

struct ExpandableButton<Content: View>: View {
    // Properties
    @State private var isExpanded = false
    private let mainButtonLabel: String
    private let mainButtonColor: Color
    private let buttonsContent: Content
    
    // Init with custom content
    init(
        label: String = "Menu",
        color: Color = .blue,
        @ViewBuilder content: () -> Content
    ) {
        self.mainButtonLabel = label
        self.mainButtonColor = color
        self.buttonsContent = content()
    }
    
    // Body
    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Full screen clear background to detect taps outside
            if isExpanded {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isExpanded = false
                        }
                    }
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack(spacing: 10) {
                CircleButton(function: toggleMenu, tint: mainButtonColor, imageSystemName: isExpanded ? "chevron.up" : "chevron.down", title: "M")
                
                // Content drops down below the button
                if isExpanded {
                    VStack {
                        buttonsContent
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(0)
                }
            }
            .zIndex(1) // Ensure our content stays above the clear background
        }
    }
    
    func toggleMenu() {
        withAnimation {
            isExpanded.toggle()
        }
        
    }
}
