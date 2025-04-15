//
//  TASFromAltimeterCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

struct TASFromAltimeterCalculatorView: View {
    @Bindable var vm: TASCalculatorViewModel
    @FocusState var focused: FocusField?
    
    var body: some View {
        VStack {
            userInputs
            computedResults
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    focused = nil
                }
            }
        }
    }
    
    var userInputs: some View {
        VStack {
            indicatedAltitude
            altimeterSetting
            outsideAirTemp
            indicatedAirSpeed
        }
    }
    
    var computedResults: some View {
        VStack {
            trueAirSpeed
            pressureAltitude
            densityAltitude
        }
    }
    
    var indicatedAltitude: some View {
        CustomTextFieldView(title: "Indicated Altitude", value: $vm.tasFromAltimeterCalculator.indicatedAltitude, placeHolder: "Altitude (ft or m)", unit: vm.tasFromAltimeterCalculator.indicatedAltitudeUnit.symbol)
            .focused($focused, equals: .indicatedAltitude)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var altimeterSetting: some View {
        CustomTextFieldView(title: "Altimeter Setting", value: $vm.tasFromAltimeterCalculator.altimeterSetting, placeHolder: "Altimeter Setting (in/hg or hpa)", unit: vm.tasFromAltimeterCalculator.altimeterSettingUnit.symbol)
            .focused($focused, equals: .altimeterSetting)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var outsideAirTemp: some View {
        CustomTextFieldView(title: "Outside Air Temperature", value: $vm.tasFromAltimeterCalculator.outsideAirTemp, placeHolder: "Temperature (°C)", unit: vm.tasFromAltimeterCalculator.outsideAirTempUnit.symbol)
            .focused($focused, equals: .oat)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var indicatedAirSpeed: some View {
        CustomTextFieldView(title: "Indicated Air Speed", value: $vm.tasFromAltimeterCalculator.indicatedAirSpeed, placeHolder: "Indicated Air Speed (IAS) (knots)", unit: vm.tasFromAltimeterCalculator.indicatedAirSpeedUnit.symbol)
            .focused($focused, equals: .ias)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var trueAirSpeed: some View {
        CustomTextView(title: "True Air Speed", value: vm.tasFromAltimeterCalculator.trueAirSpeed, unit: vm.tasFromAltimeterCalculator.indicatedAirSpeedUnit.symbol)
    }
    
    var pressureAltitude: some View {
        CustomTextView(title: "Pressure Altitude", value: vm.tasFromAltimeterCalculator.pressureAltitude, unit: vm.tasFromAltimeterCalculator.indicatedAltitudeUnit.symbol)
    }
    
    var densityAltitude: some View {
        CustomTextView(title: "Density Altitude", value: vm.tasFromAltimeterCalculator.densityAltitude, unit: vm.tasFromAltimeterCalculator.indicatedAltitudeUnit.symbol)
    }
}

extension TASFromAltimeterCalculatorView {
    enum FocusField {
        case indicatedAltitude, altimeterSetting, oat, ias
        
        func next() -> FocusField? {
            switch self {
            case .indicatedAltitude:
                return .altimeterSetting
            case .altimeterSetting:
                return .oat
            case .oat:
                return .ias
            case .ias:
                return nil
            }
        }
    }
}

#Preview {
    @Previewable @State var vm = TASCalculatorViewModel()
    TASFromAltimeterCalculatorView(vm: vm)
}

