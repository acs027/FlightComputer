//
//  WindCorrectionCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 19.02.2025.
//

import SwiftUI

struct WindCorrectionCalculatorView: View {
    @State var vm = WindCorrectionViewModel()
    
    let columns = [
//            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    struct Constants {
        static let bgColor: Color = Color(.systemGroupedBackground)
    }
    
    var body: some View {
        ScrollView {
            VStack {
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
    }
    
    var windSpeedTextField: some View {
        CustomTextFieldView(title: "Wind Speed", value: $vm.wCACalculator.windSpeed, placeHolder: "Enter wind speed")
    }
    var courseTextField: some View {
        CustomTextFieldView(title: "Course", value: $vm.wCACalculator.trueCourse, placeHolder: "Enter the course")
    }
    var trueAirSpeedTextField: some View {
        CustomTextFieldView(title: "True Air Speed", value: $vm.wCACalculator.trueAirSpeed, placeHolder: "Enter TAS")
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
