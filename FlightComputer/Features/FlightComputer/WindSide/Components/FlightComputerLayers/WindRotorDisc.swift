//
//  WindRotorDisc.swift
//  FlightComputer
//
//  Created by ali cihan on 18.03.2025.
//

import SwiftUI

struct WindRotorDisc: View {
    let rotation: Double
    let verticalOffset: CGFloat
    
    var body: some View {
        Image("windsiderotor")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotationEffect(Angle(degrees: -rotation), anchor: UnitPoint(x: 0.5, y: 0.5))
            .offset(y: verticalOffset)
    }
}

//#Preview {
//    WindRotorDisc()
//}
