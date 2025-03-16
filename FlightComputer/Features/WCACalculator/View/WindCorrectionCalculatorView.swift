//
//  WindCorrectionCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 19.02.2025.
//

import SwiftUI

extension WindCorrectionCalculatorView {
    enum WCAFocus {
        case windDirectionTextField
        case windSpeedTextField
        case courseTextField
        case trueAirSpeedTextField
        case notFocused
        
        mutating func next() {
            switch self {
            case .windDirectionTextField:
                self = .windSpeedTextField
            case .windSpeedTextField:
                self = .courseTextField
            case .courseTextField:
                self = .trueAirSpeedTextField
            case .trueAirSpeedTextField:
                self = .notFocused
            case .notFocused:
                return
            }
        }
    }
}

struct WindCorrectionCalculatorView: View {
    @State var vm = WindCorrectionViewModel()
    @FocusState var focused: WCAFocus?
    
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
                FlightTimeCalculatorView(vm: vm)
                FuelConsumptionView(vm: vm)
            }
        }
        .scrollIndicators(.hidden)
        .background(Constants.bgColor)
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
        CustomTextFieldView(title: "Wind Direction", value: $vm.wCACalculator.windDirection, placeHolder: "Enter wind direction")
            .focused($focused, equals: .windDirectionTextField)
            .onSubmit {
                focused?.next()
            }
    }
    
    var windSpeedTextField: some View {
        CustomTextFieldView(title: "Wind Speed", value: $vm.wCACalculator.windSpeed, placeHolder: "Enter wind speed")
            .focused($focused, equals: .windSpeedTextField)
            .onSubmit {
                focused?.next()
            }
    }
    var courseTextField: some View {
        CustomTextFieldView(title: "Course", value: $vm.wCACalculator.trueCourse, placeHolder: "Enter the course")
            .focused($focused, equals: .courseTextField)
            .onSubmit {
                focused?.next()
            }
    }
    var trueAirSpeedTextField: some View {
        CustomTextFieldView(title: "True Air Speed", value: $vm.wCACalculator.trueAirSpeed, placeHolder: "Enter TAS")
            .focused($focused, equals: .trueAirSpeedTextField)
            .onSubmit {
                focused?.next()
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
