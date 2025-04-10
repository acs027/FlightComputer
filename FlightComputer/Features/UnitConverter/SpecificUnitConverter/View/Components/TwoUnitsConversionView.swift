//
//  TwoUnitsConversion.swift
//  FlightComputer
//
//  Created by ali cihan on 21.02.2025.
//

import SwiftUI

struct TwoUnitsConversionView<U: UnitType>: View {
    @Binding var mainUnit: U
    @Binding var toUnit: U
    let units: [U]
    @Binding var value: Double
    var inputText: String
    
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
            Text(inputText)
                .frame(maxWidth: .infinity, alignment: .leading)
                .modifier(CustomTextFieldModifier())
                
            Text("\(mainUnit.symbol)")
                .padding()
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .modifier(CustomTextFieldBgStyle())
    }
    
    var convertedValueText: some View {
        HStack {
            Text(formattedString)
                .modifier(CustomTextStyle())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(toUnit.symbol)
                .padding()
        }
        .modifier(CustomTextFieldBgStyle())
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

#Preview {
    @Previewable @State var mainUnit = Volume.liters
    @Previewable @State var toUnit = Volume.milliliters
    @Previewable @State var value: Double = 40
    let units = Array(Volume.allCases)
    TwoUnitsConversionView(mainUnit: $mainUnit,
                       toUnit: $toUnit,
                       units: units,
                       value: $value,
                       inputText: ""
    )
}
