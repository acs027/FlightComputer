//
//  TASFromPressureAltCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

import SwiftUI

struct TASFromPressureAltCalculatorView: View {
    @Bindable var vm: TASCalculatorViewModel
    @FocusState var focused: FocusField?
    
    var body: some View {
        VStack {
            userInputs
            computedResults
        }
    }
    
    var userInputs: some View {
        VStack {
            pressureAltitude
            outsideAirTemp
            indicatedAirSpeed
        }
    }
    
    var computedResults: some View {
        VStack {
            trueAirSpeed
        }
    }
    
    var pressureAltitude: some View {
        CustomTextFieldView(title: "Pressure Altitude", value: $vm.tasFromPressureAltCalculator.pressureAltitude, placeHolder: "Altitude (m)")
            .focused($focused, equals: .pressureAltitude)
            .onSubmit {
                focused?.next()
            }
    }
    
    var outsideAirTemp: some View {
        CustomTextFieldView(title: "Outside Air Temperature", value: $vm.tasFromPressureAltCalculator.outsideAirTemp, placeHolder: "Temperature (°C)")
            .focused($focused, equals: .oat)
            .onSubmit {
                focused?.next()
            }
    }
    
    var indicatedAirSpeed: some View {
        CustomTextFieldView(title: "Indicated Air Speed", value: $vm.tasFromPressureAltCalculator.indicatedAirSpeed, placeHolder: "Indicated Air Speed (IAS) (knots)")
            .focused($focused, equals: .ias)
            .onSubmit {
                focused?.next()
            }
    }
    
    var trueAirSpeed: some View {
        CustomTextView(title: "True Air Speed", value: vm.tasFromPressureAltCalculator.trueAirSpeed)
    }
}

extension TASFromPressureAltCalculatorView {
    enum FocusField {
        case pressureAltitude, oat, ias, notFocused
        
        mutating func next() {
            switch self {
            case .pressureAltitude:
                self = .oat
            case .oat:
                self = .ias
            case .ias:
                self = .notFocused
            default:
                self = .pressureAltitude
            }
        }
    }
}

#Preview {
    @Previewable @State var vm = TASCalculatorViewModel()
    TASFromPressureAltCalculatorView(vm: vm)
}

