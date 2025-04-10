//
//  WindMarkOnRotor.swift
//  FlightComputer
//
//  Created by ali cihan on 18.03.2025.
//

import SwiftUI

struct WindMarkOnRotor: View {
    let verticalOffset: CGFloat
    let windMarkOffset: CGSize
    let windMarkDegree: () -> Double
    
    var body: some View {
        Group {
            Circle()
                .frame(width: 5)
                .offset(x: windMarkOffset.width)
                .offset(y: -windMarkOffset.height)
                .rotationEffect(Angle(degrees: windMarkDegree()))
        }
        .offset(y: verticalOffset)
    }
}

//#Preview {
//    WindMarkOnRotor()
//}
