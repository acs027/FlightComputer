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
        }
    }
    
    var indicatedAltitude: some View {
        CustomTextFieldView(title: "Indicated Altitude", value: $vm.tasFromAltimeterCalculator.indicatedAltitude, placeHolder: "Altitude (ft or m)")
            .focused($focused, equals: .indicatedAltitude)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var altimeterSetting: some View {
        CustomTextFieldView(title: "Altimeter Setting", value: $vm.tasFromAltimeterCalculator.altimeterSetting, placeHolder: "Altimeter Setting (in/hg or hpa)")
            .focused($focused, equals: .altimeterSetting)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var outsideAirTemp: some View {
        CustomTextFieldView(title: "Outside Air Temperature", value: $vm.tasFromAltimeterCalculator.outsideAirTemp, placeHolder: "Temperature (°C)")
            .focused($focused, equals: .oat)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var indicatedAirSpeed: some View {
        CustomTextFieldView(title: "Indicated Air Speed", value: $vm.tasFromAltimeterCalculator.indicatedAirSpeed, placeHolder: "Indicated Air Speed (IAS) (knots)")
            .focused($focused, equals: .ias)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var trueAirSpeed: some View {
        CustomTextView(title: "True Air Speed", value: vm.tasFromAltimeterCalculator.trueAirSpeed)
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

