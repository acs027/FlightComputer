//
//  WindStatorDisc.swift
//  FlightComputer
//
//  Created by ali cihan on 18.03.2025.
//

import SwiftUI

struct WindStatorDisc: View {
    let verticalOffset: CGFloat
    @Binding var componentWidth: CGFloat
    
    var body: some View {
        Image("windsiderotorouter")
            .resizable()
            .scaledToFit()
            .offset(y: verticalOffset)
            .overlay {
                GeometryReader {
                    geometry in
                    Color.clear
                        .onChange(of: geometry.size.width) { oldValue, newValue in
                            componentWidth = geometry.size.width
                        }
                        .onAppear{
                            componentWidth = geometry.size.width
                        }
                }
            }
    }
}

//#Preview {
//    WindStatorDisc()
//}
