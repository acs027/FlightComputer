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
    
    var body: some View {
        VStack {
            IllustrationView(vm: vm)
            LazyVGrid(columns: columns) {
                windDirectionText
                windSpeed
                courseTextField
                trueAirSpeedTextField
            }
        }
    }
    
    var windDirectionText: some View {
        VStack(alignment: .center){
            Text("Wind Direction")
                    TextField("Wind Direction:", value: $vm.wCACalculator.windDirection, format: .number)
                .textFieldStyle(.roundedBorder)
        }
        .background(.gray)
    }
    var windSpeed: some View {
        VStack{
            Text("Wind Speed")
                TextField("Course :", value: $vm.wCACalculator.windSpeed, format: .number)
            }
    }
    var courseTextField: some View {
            VStack {
                Text("Course")
                TextField("Course :", value: $vm.wCACalculator.trueCourse, format: .number)
            }
    }
    var trueAirSpeedTextField: some View {
            VStack {
                Text("True Air Speed")
                TextField("TAS :", value: $vm.wCACalculator.trueAirSpeed, format: .number)
            }
    }
}

#Preview {
    WindCorrectionCalculatorView()
}
