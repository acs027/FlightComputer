//
//  CalculatorListView.swift
//  FlightComputer
//
//  Created by ali cihan on 24.02.2025.
//

import SwiftUI

struct CalculatorListView: View {
    @State var viewModel = CalculatorViewModel()
    @EnvironmentObject var adManager: InterstitialAdManager
    @Environment(\.dismiss) var dismiss
    let gridItems = [
        GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: gridItems) {
                ForEach(Calculator.allCases, id: \.description) { calculator in
                    NavigationLink {
                        calculator.calculatorView
                            .background(Color(.systemGroupedBackground))
                            .onAppear {
                                adManager.showAd()
                            }
                    } label: {
                        calculatorLabel(calculator: calculator)
                    }
                }
            }
        }
        .padding()
        .scrollIndicators(.hidden)
        .tint(.primary)
        .frame(maxHeight: .infinity, alignment: .top)
        .navigationTitle("Calculators")
        .overlay {
            ZStack(alignment: .bottom) {
                Color.clear
                privacyPolicyButton
            }
            .padding()
        }
    }
    
    private var privacyPolicyButton: some View {
        Button {
            if let url = URL(string: "https://gist.github.com/acs027/a3fb3840ad9847f0994bc716da1f4bd4") {
                                    UIApplication.shared.open(url)
                                }
        } label: {
            Text("Privacy Policy")
        }
    }
    
    func calculatorLabel(calculator: Calculator) -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.gray.gradient)
                .frame(width: 100, height: 100)
                .overlay {
                    Image(systemName: calculator.systemImage)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            Text(calculator.description)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
}

extension Calculator {
    @ViewBuilder
    var calculatorView: some View {
        switch self {
        case .cloudBase:
            CloudBaseCalculatorView()
        case .course:
            CourseCalculatorView()
        case .densityAltitude:
            DensityAltitudeCalculatorView()
        case .dewpoint:
            DewpointCalculatorView()
        case .ias:
            IASCalculatorView()
        case .machSpeed:
            MachSpeedCalculatorView()
        case .pressureAltitude:
            PressureAltitudeCalculatorView()
        case .relativeHumidity:
            RelativeHumidityCalculatorView()
        case .speedOfSound:
            SpeedOfSoundCalculatorView()
        case .tas:
            TASCalculatorView()
        case .windComponent:
            WindComponentCalculatorView()
        case .windDirectionSpeed:
            WindDirectionSpeedCalculatorView()
        }
    }
}

#Preview {
    CalculatorListView()
}
