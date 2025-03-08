//
//  ComputerView.swift
//  FlightComputer
//
//  Created by ali cihan on 15.02.2025.
//

import SwiftUI

struct ComputerView: View {
    @State var rotation: Angle = Angle(degrees: 0)
    @GestureState var gestureRotation : Angle = Angle(degrees: 0)
    
    @State var scale: CGFloat = 1
    @GestureState var gestureScale: CGFloat = 1
    
    @State var pan: CGOffset = .zero
    @GestureState var gesturePan: CGOffset = .zero
    var body: some View {
        ZStack {
            Image("flightcomputerouter")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Image("flightcomputerinner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .rotationEffect(rotation + gestureRotation)
                .gesture(
                    RotateGesture()
                        .updating($gestureRotation) { value, state, _ in
                            state = value.rotation
                        }
                        .onEnded({ value in
                            let totalRotation = (rotation + value.rotation).degrees.truncatingRemainder(dividingBy: 360)
                            rotation = Angle(degrees: totalRotation)
                        })
                )
        }
        .scaleEffect(scale * gestureScale)
        .offset(pan + gesturePan)
        .padding()
    }
}

#Preview {
    ComputerView()
}
