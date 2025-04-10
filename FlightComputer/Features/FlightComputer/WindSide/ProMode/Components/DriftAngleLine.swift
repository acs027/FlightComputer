//
//  StaticDriftAngleLine.swift
//  FlightComputer
//
//  Created by ali cihan on 18.03.2025.
//

import SwiftUI

struct DriftAngleLine: View {
    let vm: WindSideProViewModel
    let isDynamic: Bool
    
    
    var body: some View {
        ZStack {
            ForEach(vm.lineAngleInfos, id:\.id) { lineAngle in
                lineOnAngle(lineAngle: lineAngle.degree, startDegree: lineAngle.rotation, isDynamic: lineAngle.isDynamic)
            }
        }
    }
    
    func lineOnAngle(lineAngle: Double, startDegree: Double, isDynamic: Bool) -> some View {
        Rectangle()
            .frame(width: 3, height: abs(260 * vm.unitHeight))
            .opacity(0)
            .foregroundStyle(.blue)
            .overlay {
                baseLineOnAngle(lineAngle: lineAngle)
                    .foregroundStyle(.green)
            }
            .rotationEffect(rotation(startDegree: startDegree, isDynamic: isDynamic), anchor: UnitPoint(x: 0.5, y: (130 + vm.verticalOffset / vm.unitHeight) / 260))
            .mask {
                lineOnAngleMask
            }
            .opacity(vm.islineShowing ? 1 : 0)
    }
    
    private var lineOnAngleMask: some View {
        Circle()
            .frame(width: vm.unitHeight * 100)
            .offset(
                x: sin(-Angle(degrees: vm.rotationDegree).radians) * vm.verticalOffset,
                y: cos(-Angle(degrees: vm.rotationDegree).radians) * vm.verticalOffset
            )
            .rotationEffect(-Angle(degrees: vm.rotationDegree))
    }
    
    private func baseLineOnAngle(lineAngle: Double) -> some View {
        Rectangle()
            .frame(width: 2, height: abs(260 * vm.unitHeight))
            .rotationEffect(Angle(degrees: lineAngle), anchor: .bottom)
            .offset(
                x: vm.angleLineOffset(angle: Angle(degrees: lineAngle).radians).x,
                y: vm.angleLineOffset(angle: Angle(degrees: lineAngle).radians).y
            )
    }
    
    func rotation(startDegree: Double, isDynamic: Bool) -> Angle {
        let rotation = vm.lineDegree(rotation: vm.rotationDegree, startDegree: startDegree, isDynamic: isDynamic)
        return Angle(degrees: rotation)
    }
}


