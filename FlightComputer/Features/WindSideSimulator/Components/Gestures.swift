//
//  WindSideGestures.swift
//  FlightComputer
//
//  Created by ali cihan on 7.03.2025.
//

import SwiftUI

struct PanGesture: Gesture {
    @Binding var gesturePan: CGSize
    @Binding var pan: CGSize
    @GestureState private var internalGesture: CGSize = .zero
    
    var body: some Gesture {
        DragGesture()
            .updating($internalGesture) { value, state, _ in
                state = value.translation
                gesturePan = value.translation
            }
            .onEnded({ value in
                pan += value.translation
                gesturePan = .zero
            })
    }
    
}

struct MagnifyGestureHandler: Gesture {
    @Binding var gestureScale: CGFloat
    @Binding var scale: CGFloat
    @GestureState private var internalGesture: CGFloat = 1
    
    var body: some Gesture {
        MagnifyGesture()
            .updating($internalGesture) { value, state, _ in
                state = value.magnification
                gestureScale = value.magnification
            }
            .onEnded({ value in
                scale *= value.magnification
                gestureScale = 1
            })
    }
}

