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
    }
    
    var windSpeedTextField: some View {
        CustomTextFieldView(title: "Wind Speed", value: $vm.wCACalculator.windSpeed, placeHolder: "Enter wind speed")
            .focused($focused, equals: .windSpeedTextField)
    }
    var courseTextField: some View {
        CustomTextFieldView(title: "Course", value: $vm.wCACalculator.trueCourse, placeHolder: "Enter the course")
            .focused($focused, equals: .courseTextField)
    }
    var trueAirSpeedTextField: some View {
        CustomTextFieldView(title: "True Air Speed", value: $vm.wCACalculator.trueAirSpeed, placeHolder: "Enter TAS")
            .focused($focused, equals: .trueAirSpeedTextField)
    }
    
    var windCorrectionAngle: some View {
        CustomTextView(title: "Wind Correction Angle", value: vm.wCACalculator.windCorrectionAngle ?? 0)
    }
    
    var heading: some View {
        CustomTextView(title: "Heading", value: vm.wCACalculator.heading ?? 0)
    }
    var groundSpeed: some View {
        CustomTextView(title: "Ground Speed", value: vm.wCACalculator.groundSpeed ?? 0)
    }
}

#Preview {
    WindCorrectionCalculatorView()
}
