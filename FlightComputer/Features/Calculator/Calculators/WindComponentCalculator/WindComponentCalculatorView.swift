//
//  WindComponentCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

struct WindComponentCalculatorView: View {
    @State var vm = WindComponentCalculatorViewModel()
    
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
            windSpeed
            windDirection
            runwayHeading
        }
    }
    
    var computedResults: some View {
        VStack {
            headWind
            crossWind
        }
    }
    
    var windSpeed: some View {
        CustomTextFieldView(title: "Wind Speed", value: $vm.windComponentCalculator.windSpeed, placeHolder: "Wind Speed (knots)")
    }
    
    var windDirection: some View {
        CustomTextFieldView(title: "Wind Direction", value: $vm.windComponentCalculator.windDirection, placeHolder: "Wind Direction (° from North)")
    }
    
    var runwayHeading: some View {
        CustomTextFieldView(title: "Runway Heading", value: $vm.windComponentCalculator.runwayHeading, placeHolder: "Runway Heading (°)")
    }
    
    var headWind: some View {
        CustomTextView(title: "Headwind Component", value: vm.windComponentCalculator.headWind)
    }
    
    var crossWind: some View {
        CustomTextView(title: "Crosswind Component", value: vm.windComponentCalculator.crossWind)
    }
}

#Preview {
//    @Previewable @State var vm = WindComponentCalculatorViewModel()
    WindComponentCalculatorView()
}

