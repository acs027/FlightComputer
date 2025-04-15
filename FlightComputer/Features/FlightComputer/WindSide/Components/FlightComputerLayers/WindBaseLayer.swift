//
//  WindBaseLayer.swift
//  FlightComputer
//
//  Created by ali cihan on 18.03.2025.
//

import SwiftUI

struct WindBaseLayer: View {
    let geometryChangeHandler: (_ newValue: CGSize, _ oldValue: CGSize) -> Void
    let backgroundOnAppearHandler: (_ geometySize: CGSize) -> Void
    var isHighSpeed: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("windsidebackground")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width)
                    .onChange(of: geometry.size) { oldValue, newValue in
                        geometryChangeHandler(newValue, oldValue)
                    }
                    .onAppear {
                        backgroundOnAppearHandler(geometry.size)
                    }
                Image("windsidehighspeedoverlay")
                    .resizable()
                    .scaledToFit()
                    .opacity(isHighSpeed ? 1 : 0)
            }
            
        }
    }
}

//#Preview {
//    WindBaseLayer()
//}
