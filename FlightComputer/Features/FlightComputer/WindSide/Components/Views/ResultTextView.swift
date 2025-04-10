//
//  ResultTextView.swift
//  FlightComputer
//
//  Created by ali cihan on 17.02.2025.
//

import SwiftUI


//
//struct ResultTextView: View {
//    let label: String
//    let value: Double
//    let valueType: ValueType
//    
//    
//    var body: some View {
//        Text("\(label): \(valueType.string(value: value))")
//            .bold()
//        .padding(10)
//        .foregroundStyle(Constants.textColor)
//        .background(
//            RoundedRectangle(cornerRadius: 10)
//                .foregroundStyle(Constants.bgColor)
//        )
//    }
//    
//    struct Constants {
//        static let bgColor: AnyGradient = Color(.secondarySystemBackground).gradient
//        static let textColor: Color = .primary
//    }
//}
//
//#Preview {
//    VStack {
//        HStack {
//            ResultTextView(label: "Wind Speed", value: 360, valueType: .angle)
//            ResultTextView(label: "Wind Speed", value: 360, valueType: .double)
//        }
//    }
//}

//import SwiftUI

enum ValueType {
    case angle, double
    
    func string(value: Double) -> String {
        switch self {
        case .angle:
            return String(format: "%.0f°", value)
        case .double:
            return String(format: "%.2f", value)
        }
    }
}

struct ResultTextView: View {
    // MARK: - Properties
    let label: String
    let value: Double
    let valueType: ValueType
    
    // Customization options
    var fontSize: CGFloat = 15
    var horizontalPadding: CGFloat = 16
    var verticalPadding: CGFloat = 12
    
    // MARK: - Body
    var body: some View {
        HStack(spacing: 6) {
            // Label
            Text(label)
                .font(.system(size: fontSize, weight: .medium))
                .foregroundStyle(Constants.labelColor)
            
            Spacer(minLength: 4)
            
            // Value with divider
            Text(valueType.string(value: value))
                .font(.system(size: fontSize, weight: .semibold))
                .foregroundStyle(Constants.valueColor)
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .frame(minWidth: 120)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Constants.bgColor)
                
                // Subtle border
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Constants.borderColor, lineWidth: 1)
            }
        )
        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
        .frame(width: 150)
    }
    
    // MARK: - Constants
    struct Constants {
        static let bgColor = Color(.secondarySystemBackground)
        static let borderColor = Color.gray.opacity(0.15)
        static let labelColor = Color.primary.opacity(0.7)
        static let valueColor = Color.primary
    }
}

// MARK: - Preview
struct ResultTextView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Light mode preview
            VStack(spacing: 16) {
                ResultTextView(
                    label: "Heading",
                    value: 270.0,
                    valueType: .angle
                )
                
                ResultTextView(
                    label: "Bank Angle",
                    value: 15.0,
                    valueType: .angle
                )
                
                ResultTextView(
                    label: "True Airspeed",
                    value: 145.37,
                    valueType: .double
                )
                
                ResultTextView(
                    label: "Fuel Remaining",
                    value: 32.45,
                    valueType: .double,
                    fontSize: 16,
                    horizontalPadding: 20,
                    verticalPadding: 14
                )
            }
            .padding()
            .background(Color.white)
            .previewDisplayName("Light Mode")
            
            // Dark mode preview
            VStack(spacing: 16) {
                ResultTextView(
                    label: "Heading",
                    value: 270.0,
                    valueType: .angle
                )
                
                ResultTextView(
                    label: "Bank Angle",
                    value: 15.0,
                    valueType: .angle
                )
                
                ResultTextView(
                    label: "True Airspeed",
                    value: 145.37,
                    valueType: .double
                )
                
                ResultTextView(
                    label: "Fuel Remaining",
                    value: 32.45,
                    valueType: .double
                )
            }
            .padding()
            .background(Color.black)
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
        }
    }
}
