//
//  TwoUnitsConversion.swift
//  FlightComputer
//
//  Created by ali cihan on 21.02.2025.
//

import SwiftUI

struct TwoUnitsConversion<U: UnitType>: View {
    @Binding var mainUnit: U
    @Binding var toUnit: U
    @FocusState var focused: U?
    let units: [U]
    @Binding var value: Double
    
    var convertedValue: Double {
        mainUnit.convert(value: value, to: toUnit)
    }
    var formattedString: String {
        FormatterUtils.sharedNumberFormatter.string(from: convertedValue as NSNumber) ?? ""
        
    }
    
    var body: some View {
        VStack {
            textField
            unitPickers
            convertedValueText
        }
    }
    
    var textField: some View {
        HStack {
            TextField("Value", value: $value, formatter: FormatterUtils.sharedNumberFormatter)
                .focused($focused, equals: mainUnit)
                .modifier(UCTextFieldStyle())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(mainUnit.symbol)")
                .padding()
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .modifier(UCTextFieldBackgroundStyle())
    }
    
    var convertedValueText: some View {
        HStack {
            Text(formattedString)
                .modifier(UCTextStyle())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(toUnit.symbol)
                .padding()
        }
        .modifier(UCTextFieldBackgroundStyle())
    }
    
    var unitPickers: some View {
        VStack {
            Picker("Current Unit", selection: $mainUnit) {
                ForEach(units, id: \.symbol) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .frame(height: 50)
            .pickerStyle(.segmented)
            Picker("Current Unit", selection: $toUnit) {
                ForEach(units, id: \.symbol) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .frame(height: 50)
            .pickerStyle(.segmented)
        }
    }
}

//MARK: Constants
private struct Constants {
//    static let textFieldBg: Color = Color(.systemBackground)
    static let textFieldBg: Color = Color(.tertiarySystemBackground)
    static let textFieldSecondaryBg: Color = Color(.systemBackground)
}


struct UCTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Constants.textFieldBg)
            .cornerRadius(8)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            }
    }
}

struct UCTextFieldBackgroundStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .padding(10)
        .background(Constants.textFieldSecondaryBg)
        .cornerRadius(10)
    }
}

struct UCTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .padding(10)
            .background(Constants.textFieldBg)
            .cornerRadius(8)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            }
    }
}


#Preview {
    @Previewable @State var mainUnit = UnitConversion.Volume.liters
    @Previewable @State var toUnit = UnitConversion.Volume.milliliters
    @Previewable @State var value: Double = 40
    let units = Array(UnitConversion.Volume.allCases)
    TwoUnitsConversion(mainUnit: $mainUnit, toUnit: $toUnit, units: units, value: $value)
}
