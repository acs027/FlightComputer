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
        CustomTextFieldView(title: "Aircraft Heading", value: $vm.windDirectionSpeedCalculator.heading, placeHolder: "Heading (° from North)")
            .focused($focused, equals: .heading)
            .onSubmit {
                focused?.next()
            }
    }
    
    var trueAirSpeed: some View {
        CustomTextFieldView(title: "True Airspeed", value: $vm.windDirectionSpeedCalculator.trueAirSpeed, placeHolder: "TAS (knots)")
            .focused($focused, equals: .tas)
            .onSubmit {
                focused?.next()
            }
    }
    
    var trueCourse: some View {
        CustomTextFieldView(title: "True Course", value: $vm.windDirectionSpeedCalculator.trueCourse, placeHolder: "Course (° from North)")
            .focused($focused, equals: .trueCourse)
            .onSubmit {
                focused?.next()
            }
    }
    
    var groundSpeed: some View {
        CustomTextFieldView(title: "Ground Speed", value: $vm.windDirectionSpeedCalculator.groundSpeed, placeHolder: "Ground Speed (knots)")
            .focused($focused, equals: .groundSpeed)
            .onSubmit {
                focused?.next()
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
        case heading, tas, trueCourse, groundSpeed, notFocused
        
        mutating func next() {
            switch self {
            case .heading:
                self = .tas
            case .tas:
                self = .trueCourse
            case .trueCourse:
                self = .groundSpeed
            case .groundSpeed:
                self = .notFocused
            default:
                self = .heading
            }
        }
    }
}

#Preview {
//    @Previewable @State var vm = WindDirectionSpeedCalculatorViewModel()
    WindDirectionSpeedCalculatorView()
}


