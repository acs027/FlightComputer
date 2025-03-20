//
//  LineToWindMarkOnRotor.swift
//  FlightComputer
//
//  Created by ali cihan on 18.03.2025.
//

import SwiftUI

struct LineToWindMarkOnRotor: View {
    let verticalOffset: CGFloat
    let windMarkOffset: CGSize
    let windMarkDegree: () -> Double
    
    var body: some View {
        Group {
            Rectangle()
                .frame(width: 1, height: abs(windMarkOffset.height))
                .offset(y: -windMarkOffset.height / 2)
                .rotationEffect(Angle(degrees: windMarkDegree()))
        }
        .offset(y: verticalOffset )
    }
}

//#Preview {
//    LineToWindMarkOnRotor()
//}
