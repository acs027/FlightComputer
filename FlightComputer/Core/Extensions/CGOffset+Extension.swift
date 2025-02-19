//
//  Extension.swift
//  FlightComputer
//
//  Created by ali cihan on 9.02.2025.
//

import Foundation

typealias CGOffset = CGSize


extension CGOffset {
    static func +(lhs: CGOffset, rhs: CGOffset) -> CGOffset {
        CGOffset(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    static func +=(lhs: inout CGOffset, rhs: CGOffset) {
        lhs = lhs + rhs
    }
}
