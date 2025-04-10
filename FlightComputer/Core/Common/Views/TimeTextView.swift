//
//  TimeTextView.swift
//  FlightComputer
//
//  Created by ali cihan on 6.03.2025.
//

import SwiftUI

struct TimeTextView: View {
    let title: String
    let value: Double
    var unit: String?
    
    var formattedValue: String {
        if value > 0 {
            return FormatterUtils.formatTime(value)
        }
        return ""
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
            HStack {
                Text("\(formattedValue)")
                    .modifier(CustomTextStyle())
                if let unit = unit {
                    Text(unit)
                }
            }
            
        }
        .padding()
        .background(Color("textfieldframebg"))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
