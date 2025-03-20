//
//  ProController.swift
//  FlightComputer
//
//  Created by ali cihan on 18.03.2025.
//

import Foundation

enum ProController: CaseIterable {
    case vertical
    case rotation
    case wind
    case line
    
    var systemImage: String {
        switch self {
        case .vertical:
            "arrow.up.and.line.horizontal.and.arrow.down"
        case .rotation:
            "arrow.trianglehead.2.clockwise.rotate.90"
        case .wind:
            "wind"
        case .line:
            "line.horizontal.3.decrease"
        }
    }
}
