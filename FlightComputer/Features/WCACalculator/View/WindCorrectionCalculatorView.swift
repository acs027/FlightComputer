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
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    struct Constants {
        static let bgColor: Color = Color(.systemBackground)
    }
    
    var body: some View {
        VStack {
            IllustrationView(vm: vm)
            LazyVGrid(columns: columns, spacing: 5) {
                windDirectionTextField
                windSpeedTextField
                courseTextField
                trueAirSpeedTextField
            }
        }
        .background(Constants.bgColor)
    }
    
    var windDirectionTextField: some View {
        WCATextField(title: "Wind Direction", value: $vm.wCACalculator.windDirection, placeHolder: "Enter wind direction")
    }
    
    var windSpeedTextField: some View {
        WCATextField(title: "Wind Speed", value: $vm.wCACalculator.windSpeed, placeHolder: "Enter wind speed")
    }
    var courseTextField: some View {
        WCATextField(title: "Course", value: $vm.wCACalculator.trueCourse, placeHolder: "Enter the course")
    }
    var trueAirSpeedTextField: some View {
        WCATextField(title: "True Air Speed", value: $vm.wCACalculator.trueAirSpeed, placeHolder: "Enter TAS")
    }
}



#Preview {
    WindCorrectionCalculatorView()
}
