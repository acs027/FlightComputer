//
//  File.swift
//  FlightComputer
//
//  Created by ali cihan on 19.02.2025.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width / 2, y: 0)) // Arrow tip
        path.addLine(to: CGPoint(x: width, y: height * 0.5))
        path.addLine(to: CGPoint(x: width * 0.6, y: height * 0.5))
        path.addLine(to: CGPoint(x: width * 0.6, y: height))
        path.addLine(to: CGPoint(x: width * 0.4, y: height))
        path.addLine(to: CGPoint(x: width * 0.4, y: height * 0.5))
        path.addLine(to: CGPoint(x: 0, y: height * 0.5))
        path.closeSubpath()
        
        return path
    }
}
