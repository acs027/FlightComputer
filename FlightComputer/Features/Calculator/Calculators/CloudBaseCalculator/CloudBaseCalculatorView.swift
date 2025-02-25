//
//  CloudBaseCalculatorView.swift
//  FlightComputer
//
//  Created by ali cihan on 25.02.2025.
//

import SwiftUI

struct CloudBaseCalculatorView: View {
    @State var vm = CloudBaseCalculatorViewModel()
    
    var body: some View {
        ScrollView {
                userInputs
                computedResults
        }
    }
    
    var userInputs: some View {
        VStack {
            ambientTemp
            ambientDewpoint
            stationAltitude
        }
    }
    
    var computedResults: some View {
        VStack {
            cloudBaseAltitude
        }
    }
    
    var ambientTemp: some View {
        CustomTextFieldView(title: "Ambient Temperature", value: $vm.cloudBaseCalculator.ambientTemp, placeHolder: "Temperature (°C)")
    }
    
    var ambientDewpoint: some View {
        CustomTextFieldView(title: "Dewpoint", value: $vm.cloudBaseCalculator.ambientDewpoint, placeHolder: "Dewpoint (°C)")
    }
    
    var stationAltitude: some View {
        CustomTextFieldView(title: "Station Altitude", value: $vm.cloudBaseCalculator.stationAltitude, placeHolder: "Altitude (m)")
    }
    
    var cloudBaseAltitude: some View {
        CustomTextView(title: "Cloud Base Altitude", value: vm.cloudBaseCalculator.cloudBaseAltitude)
    }
}

#Preview {
//    @Previewable @State var vm = CloudBaseCalculatorViewModel()
    CloudBaseCalculatorView()
}
