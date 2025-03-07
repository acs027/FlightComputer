//
//  WindSideGestures.swift
//  FlightComputer
//
//  Created by ali cihan on 7.03.2025.
//

import SwiftUI

extension WindSideView {
    //MARK: Gestures
    var panGesture: some Gesture {
        DragGesture()
            .updating($gesturePan) { value, state, _ in
                state = value.translation
            }
            .onEnded({ value in
                pan += value.translation
            })
    }
    
    var magnifyGesture: some Gesture {
        MagnifyGesture()
            .updating($gestureScale) { value, state, _ in
                state = value.magnification
            }
            .onEnded({ value in
                scale *= value.magnification
            })
    }
}

