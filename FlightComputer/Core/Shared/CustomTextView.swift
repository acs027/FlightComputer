//
//  CustomTextView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

struct CustomTextView: View {
    let title: String
    let value: Double
    
    var formattedValue: String {
        FormatterUtils.sharedNumberFormatter.string(from: value as NSNumber) ?? ""
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
            Text("\(formattedValue)")
                .modifier(CustomTextStyle())
        }
        .padding()
        .background(Color("textfieldframebg"))
        .cornerRadius(10)
        .padding()
        
        
    }
}
