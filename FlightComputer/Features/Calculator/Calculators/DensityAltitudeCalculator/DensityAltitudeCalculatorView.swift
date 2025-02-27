//
//  DensityAltitudeCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

import SwiftUI

struct DensityAltitudeCalculatorView: View {
    @State var vm = DensityAltitudeCalculatorViewModel()

    var body: some View {
        ScrollView {
            VStack {
                userInputs
                computedResults
            }
        }
    }

    var userInputs: some View {
        VStack {
            pressureAltitude
            trueAltitude
            oat
        }
    }

    var computedResults: some View {
        VStack {
            isaTemp
            densityAltitude
        }
    }

    var pressureAltitude: some View {
        VStack {
            CustomTextFieldView(title: "Pressure Altitude", value: $vm.calculator.pressureAltitude, placeHolder: "Altitude (ft)", unit: vm.calculator.pressureAltitudeUnit.symbol)
            Picker("Pressure Altitude Unit", selection: $vm.calculator.pressureAltitudeUnit) {
                ForEach(Distance.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
    }
    
    var trueAltitude: some View {
        CustomTextFieldView(title: "True Altitude", value: $vm.calculator.trueAltitude, placeHolder: "True (ft)", unit: vm.calculator.pressureAltitudeUnit.symbol)
       
    }

    var oat: some View {
        VStack {
            CustomTextFieldView(title: "Outside Air Temperature", value: $vm.calculator.oat, placeHolder: "Temperature (°C)", unit: vm.calculator.oatUnit.symbol)
            Picker("OAT Unit", selection: $vm.calculator.oatUnit) {
                ForEach(Temperature.allCases, id: \.self) {
                    unit in
                    Text(unit.symbol).tag(unit)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
    }

    var isaTemp: some View {
        CustomTextView(title: "ISA Temperature", value: vm.calculator.isaTemp, unit: vm.calculator.oatUnit.symbol)
    }

    var densityAltitude: some View {
        CustomTextView(title: "Density Altitude", value: vm.calculator.densityAltitude, unit: vm.calculator.pressureAltitudeUnit.symbol)
    }
}

#Preview {
//    @Previewable @State var vm = DensityAltitudeCalculatorViewModel()
    DensityAltitudeCalculatorView()
}
