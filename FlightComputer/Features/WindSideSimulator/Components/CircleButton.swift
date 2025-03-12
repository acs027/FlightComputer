//
//  CircleButton.swift
//  FlightComputer
//
//  Created by ali cihan on 12.03.2025.
//

import SwiftUI

struct CircleButton: View {
    let function: () -> Void
    let tint: Color
    var imageSystemName: String?
    let title: String
    
    var body: some View {
        Button {
            function()
        } label: {
            label
        }
    }
    
    @ViewBuilder
    var label: some View {
        if let image = imageSystemName {
            Image(systemName: image)
                .font(.largeTitle)
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .tint(tint)
                )
        } else {
            Text(title)
                .frame(width: 50, height: 50)
                .background(
                    Circle()
                        .tint(tint)
                )
        }
    }
}

//#Preview {
//    CircleButton()
//}

