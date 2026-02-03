//
//  CourseCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import SwiftUI

struct CourseCalculatorView: View {
    @State var vm = CourseCalculatorViewModel()
    @FocusState var focused: FocusField?
    
    var body: some View {
//        NavigationStack {
            ScrollView {
                VStack {
                    userInputs
                    computedResults
                }
            }
            .navigationTitle("Course")
//            .toolbar {
//                ToolbarItem(placement: .keyboard) {
//                    Button("Done") {
//                        focused = nil
//                    }
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//                }
//            }
//        }
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
        CustomTextFieldView<FocusField>(title: "Heading", value: $vm.courseCalculator.heading, focus: $focused, field: .heading, placeHolder: "Heading")
            .focused($focused, equals: .heading)
            .onSubmit {
                focused = focused?.next()
            }
            
    }
    var trueAirSpeed: some View {
        CustomTextFieldView<FocusField>(title: "True Air Speed", value: $vm.courseCalculator.trueAirSpeed, focus: $focused, field: .trueAirSpeed, placeHolder: "TAS")
            .focused($focused, equals: .trueAirSpeed)
            .onSubmit {
                focused = focused?.next()
            }
    }
    var windDirection: some View {
        CustomTextFieldView<FocusField>(title: "Wind Direction", value: $vm.courseCalculator.windDirection, focus: $focused, field: .windDirection, placeHolder: "Wind Direction")
            .focused($focused, equals: .windDirection)
            .onSubmit {
                focused = focused?.next()
            }
    }
    var windSpeed: some View {
        CustomTextFieldView<FocusField>(title: "Wind Speed", value: $vm.courseCalculator.windSpeed, focus: $focused, field: .windSpeed, placeHolder: "Wind speed")
            .focused($focused, equals: .windSpeed)
            .onSubmit {
                focused = focused?.next()
            }
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

extension CourseCalculatorView {
    enum FocusField {
        case heading, trueAirSpeed, windDirection, windSpeed
        
        func next() -> FocusField? {
            switch self {
            case .heading:
                return .trueAirSpeed
            case .trueAirSpeed:
                return .windDirection
            case .windDirection:
                return .windSpeed
            case .windSpeed:
                return nil
            }
        }
    }
}

#Preview {
//    @Previewable @State var vm = CourseCalculatorViewModel()
    CourseCalculatorView()
}
