//
//  WindDirectionSpeedCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import SwiftUI

struct WindDirectionSpeedCalculatorView: View {
    @State var vm = WindDirectionSpeedCalculatorViewModel()
    @FocusState var focused: FocusField?
    
    var body: some View {
        ScrollView {
            VStack {
                userInputs
                computedResults
            }
        }
        .navigationTitle("Wind")
//        .toolbar {
//            ToolbarItemGroup(placement: .keyboard) {
//                Spacer()
//                Button("Done") {
//                    focused = nil
//                }
//            }
//        }
    }
    
    var userInputs: some View {
        VStack {
            heading
            trueAirSpeed
            trueCourse
            groundSpeed
        }
    }
    
    var computedResults: some View {
        VStack {
            windSpeed
            windDirection
        }
    }
    
    var heading: some View {
        CustomTextFieldView<FocusField>(title: "Aircraft Heading", value: $vm.windDirectionSpeedCalculator.heading, focus: $focused, field: .heading, placeHolder: "Heading (° from North)")
            .focused($focused, equals: .heading)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var trueAirSpeed: some View {
        CustomTextFieldView<FocusField>(title: "True Airspeed", value: $vm.windDirectionSpeedCalculator.trueAirSpeed, focus: $focused, field: .tas, placeHolder: "TAS (knots)")
            .focused($focused, equals: .tas)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var trueCourse: some View {
        CustomTextFieldView<FocusField>(title: "True Course", value: $vm.windDirectionSpeedCalculator.trueCourse, focus: $focused, field: .trueCourse, placeHolder: "Course (° from North)")
            .focused($focused, equals: .trueCourse)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var groundSpeed: some View {
        CustomTextFieldView<FocusField>(title: "Ground Speed", value: $vm.windDirectionSpeedCalculator.groundSpeed, focus: $focused, field: .groundSpeed, placeHolder: "Ground Speed (knots)")
            .focused($focused, equals: .groundSpeed)
            .onSubmit {
                focused = focused?.next()
            }
    }
    
    var windSpeed: some View {
        CustomTextView(title: "Wind Speed", value: vm.windDirectionSpeedCalculator.windSpeed)
    }
    
    var windDirection: some View {
        CustomTextView(title: "Wind Direction", value: vm.windDirectionSpeedCalculator.windDirection)
    }
}

extension WindDirectionSpeedCalculatorView {
    enum FocusField {
        case heading, tas, trueCourse, groundSpeed
        
        func next() -> FocusField? {
            switch self {
            case .heading:
                return .tas
            case .tas:
                return .trueCourse
            case .trueCourse:
                return .groundSpeed
            case .groundSpeed:
                return nil
            }
        }
    }
}

#Preview {
//    @Previewable @State var vm = WindDirectionSpeedCalculatorViewModel()
    WindDirectionSpeedCalculatorView()
}


