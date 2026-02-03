//
//  WindCorrectionCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 19.02.2025.
//

import SwiftUI

extension WindCorrectionCalculatorView {
    enum WCACalculatorFocus: Hashable {
        case windDirectionTextField
        case windSpeedTextField
        case courseTextField
        case trueAirSpeedTextField
        case distanceField
        case groundSpeed
        case flightTime
        case fuelPerHour
        
        func next() -> WCACalculatorFocus? {
            switch self {
            case .windDirectionTextField:
                return .windSpeedTextField
            case .windSpeedTextField:
                return .courseTextField
            case .courseTextField:
                return .trueAirSpeedTextField
            case .trueAirSpeedTextField:
                return nil
            case .distanceField:
                return .groundSpeed
            case .groundSpeed:
                return nil
            case .flightTime:
                return .fuelPerHour
            case .fuelPerHour:
                return nil
            }
        }
    }
}

struct WindCorrectionCalculatorView: View {
    @State var vm = WindCorrectionViewModel()
    @FocusState var focused: WCACalculatorFocus?
    typealias FocusField = WCACalculatorFocus
    
    let columns = [
//            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    struct Constants {
        static let bgColor: Color = Color(.systemGroupedBackground)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                IllustrationView(vm: vm)
                wcaCalcComponents
                FlightTimeCalculatorView(vm: vm, focused: $focused)
                FuelConsumptionView(vm: vm, focused: $focused)
            }
        }
        .scrollIndicators(.hidden)
        .background(Constants.bgColor)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
//                Spacer()
//                Button("Done") {
//                    focused = nil
//                }
                Button("Next") {
                    focused = focused?.next()
                }
                Spacer()
            }
        }
    }
    
    var wcaCalcComponents: some View {
        LazyVGrid(columns: columns, spacing: 5) {
            windDirectionTextField
            windSpeedTextField
            courseTextField
            trueAirSpeedTextField
            windCorrectionAngle
            heading
            groundSpeed
        }
    }
    
    var windDirectionTextField: some View {
        CustomTextFieldView<FocusField>(title: "Wind Direction", value: $vm.wCACalculator.windDirection, focus: $focused, field: .windDirectionTextField, placeHolder: "Enter wind direction")
            .focused($focused, equals: .windDirectionTextField)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var windSpeedTextField: some View {
        CustomTextFieldView<FocusField>(title: "Wind Speed", value: $vm.wCACalculator.windSpeed, focus: $focused, field: .windSpeedTextField, placeHolder: "Enter wind speed")
            .focused($focused, equals: .windSpeedTextField)
            .onSubmit {
                focused = focused?.next()
            }
    }
    var courseTextField: some View {
        CustomTextFieldView<FocusField>(title: "Course", value: $vm.wCACalculator.trueCourse, focus: $focused, field: .courseTextField, placeHolder: "Enter the course")
            .focused($focused, equals: .courseTextField)
            .onSubmit {
                focused = focused?.next()
            }
    }
    var trueAirSpeedTextField: some View {
        CustomTextFieldView<FocusField>(title: "True Air Speed", value: $vm.wCACalculator.trueAirSpeed, focus: $focused, field: .trueAirSpeedTextField, placeHolder: "Enter TAS")
            .focused($focused, equals: .trueAirSpeedTextField)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var windCorrectionAngle: some View {
        CustomTextView(title: "Wind Correction Angle", value: vm.wCACalculator.windCorrectionAngle)
    }
    
    var heading: some View {
        CustomTextView(title: "Heading", value: vm.wCACalculator.heading)
    }
    var groundSpeed: some View {
        CustomTextView(title: "Ground Speed", value: vm.wCACalculator.groundSpeed)
    }
}

#Preview {
    WindCorrectionCalculatorView()
}
