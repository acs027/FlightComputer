//
//  WindDirectionSpeedCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import SwiftUI

struct WindDirectionSpeedCalculatorView: View {
    @State var vm = WindDirectionSpeedCalculatorViewModel()
    
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
            heading
            trueAirSpeed
            trueCourse
            groundSpeed
            windCorrectionAngle
        }
    }
    
    var computedResults: some View {
        VStack {
            windSpeed
            windDirection
        }
    }
    
    var heading: some View {
        CustomTextFieldView(title: "Aircraft Heading", value: $vm.windDirectionSpeedCalculator.heading, placeHolder: "Heading (° from North)")
    }
    
    var trueAirSpeed: some View {
        CustomTextFieldView(title: "True Airspeed", value: $vm.windDirectionSpeedCalculator.trueAirSpeed, placeHolder: "TAS (knots)")
    }
    
    var trueCourse: some View {
        CustomTextFieldView(title: "True Course", value: $vm.windDirectionSpeedCalculator.trueCourse, placeHolder: "Course (° from North)")
    }
    
    var groundSpeed: some View {
        CustomTextFieldView(title: "Ground Speed", value: $vm.windDirectionSpeedCalculator.groundSpeed, placeHolder: "Ground Speed (knots)")
    }
    
    var windCorrectionAngle: some View {
        CustomTextFieldView(title: "Wind Correction Angle", value: $vm.windDirectionSpeedCalculator.windCorrectionAngle, placeHolder: "Wind Correction Angle (°)")
    }
    
    var windSpeed: some View {
        CustomTextView(title: "Wind Speed", value: vm.windDirectionSpeedCalculator.windSpeed)
    }
    
    var windDirection: some View {
        CustomTextView(title: "Wind Direction", value: vm.windDirectionSpeedCalculator.windDirection)
    }
}

#Preview {
//    @Previewable @State var vm = WindDirectionSpeedCalculatorViewModel()
    WindDirectionSpeedCalculatorView()
}


