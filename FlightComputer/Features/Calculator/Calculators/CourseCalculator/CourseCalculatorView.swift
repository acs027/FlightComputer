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
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        focused = nil
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
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
        CustomTextFieldView(title: "Heading", value: $vm.courseCalculator.heading, placeHolder: "Heading")
            .focused($focused, equals: .heading)
            .onSubmit {
                focused?.next()
            }
            
    }
    var trueAirSpeed: some View {
        CustomTextFieldView(title: "True Air Speed", value: $vm.courseCalculator.trueAirSpeed, placeHolder: "TAS")
            .focused($focused, equals: .trueAirSpeed)
            .onSubmit {
                focused?.next()
            }
    }
    var windDirection: some View {
        CustomTextFieldView(title: "Wind Direction", value: $vm.courseCalculator.windDirection, placeHolder: "Wind Direction")
            .focused($focused, equals: .windDirection)
            .onSubmit {
                focused?.next()
            }
    }
    var windSpeed: some View {
        CustomTextFieldView(title: "Wind Speed", value: $vm.courseCalculator.windSpeed, placeHolder: "Wind speed")
            .focused($focused, equals: .windSpeed)
            .onSubmit {
                focused?.next()
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
        case heading, trueAirSpeed, windDirection, windSpeed, notFocused
        
        mutating func next() {
            switch self {
            case .heading:
                self = .trueAirSpeed
            case .trueAirSpeed:
                self = .windDirection
            case .windDirection:
                self = .windSpeed
            case .windSpeed:
                self = .notFocused
            default:
                self = .heading
            }
        }
    }
}

#Preview {
//    @Previewable @State var vm = CourseCalculatorViewModel()
    CourseCalculatorView()
}
