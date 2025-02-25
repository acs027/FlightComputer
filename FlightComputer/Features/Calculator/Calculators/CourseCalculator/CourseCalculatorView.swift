//
//  CourseCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import SwiftUI

struct CourseCalculatorView: View {
    @State var vm = CourseCalculatorViewModel()
    
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
            windDirection
            windSpeed
        }
    }
    
    var computedResults: some View {
        VStack {
            course
            groundSpeed
            wcaAngle
        }
    }
    
    var heading: some View {
        CustomTextFieldView(title: "Heading", value: $vm.courseCalculator.heading, placeHolder: "Heading")
    }
    var trueAirSpeed: some View {
        CustomTextFieldView(title: "True Air Speed", value: $vm.courseCalculator.trueAirSpeed, placeHolder: "TAS")
    }
    var windDirection: some View {
        CustomTextFieldView(title: "Wind Direction", value: $vm.courseCalculator.windDirection, placeHolder: "Wind Direction")
    }
    var windSpeed: some View {
        CustomTextFieldView(title: "Wind Speed", value: $vm.courseCalculator.windSpeed, placeHolder: "Wind speed")
    }
    var course: some View {
        CustomTextView(title: "Course", value: vm.courseCalculator.trueCourse)
    }
    var groundSpeed: some View {
        CustomTextView(title: "Ground Speed", value: vm.courseCalculator.groundSpeed)
    }
    var wcaAngle: some View {
        CustomTextView(title: "Wind Correction Angle", value: vm.courseCalculator.windCorrectionAngle)
    }
}

#Preview {
//    @Previewable @State var vm = CourseCalculatorViewModel()
    CourseCalculatorView()
}
