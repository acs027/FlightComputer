//
//  WindSideView.swift
//  FlightComputer
//
//  Created by ali cihan on 15.02.2025.
//

import SwiftUI

struct WindSideView: View {
    @State var vm = WindSideViewModel()
    @EnvironmentObject var adManager: InterstitialAdManager
    
    @State var height: Double = 0
    
    @State var scale: CGFloat = 1
    @State var gestureScale: CGFloat = 1
    var totalScale: CGFloat { scale * gestureScale }
    
    @State var pan: CGOffset = .zero
    @State var gesturePan: CGOffset = .zero
    var totalPan: CGOffset { pan + gesturePan }
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .center) {
            windSideComponents
            title
            controllerButtons
            values
            
        }
        .background(Constants.bgColor)
        .simultaneousGesture(
            PanGesture(gesturePan: $gesturePan, pan: $pan)
            
        )
        .simultaneousGesture(
            MagnifyGestureHandler(gestureScale: $gestureScale, scale: $scale)
        )
        .sheet(isPresented: $vm.isControllerShowing) {
            controllerView
                .padding()
                .presentationBackground(Constants.sheetBg)
                .presentationDetents([.fraction(0.4), .medium, .large])
        }
        .onChange(of: vm.calculationStepType) { oldValue, newValue in
            if oldValue != newValue {
                reset()
                scale = vm.scaleValueFitTheView()
                adManager.showAd()
            }
        }
        .onChange(of: vm.calculationStepType.isLastStep, { oldValue, newValue in
            if newValue {
                showResults()
            }
        })
        .onChange(of: vm.verticalOffset) { oldValue, newValue in
            centerTheView()
        }
        .onChange(of: vm.isHighSpeed) { oldValue, newValue in
            reset()
        }
        .onAppear {
            DispatchQueue.main.async {
                scale = vm.scaleValueFitTheView()
            }
        }
    }
    
    var title: some View {
        Text(vm.calculationStepType.title)
            .font(.headline)
            .bold()
            .minimumScaleFactor(0.5)
            .lineLimit(1)
            .frame(maxWidth: 220)
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.textfieldbg)
                    .frame(height: 50)
            )
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            .padding(.top)
    }
    
    //MARK: Constants
    struct Constants {
        static let bgColor: Color = Color(.systemGroupedBackground)
        static let controllerViewFgColor: Color = .primary
        static let mainButtonColor: AnyGradient = Color.blue.gradient
        static let buttonTextColor: Color = Color(.tertiarySystemBackground)
        static let nextButtonColor: Color = Color.green
        static let backButtonColor: Color = Color.red
        static let sheetBg: Color = Color(.systemGroupedBackground)
        static let centerButtonBgColor: Color = Color(.tertiarySystemBackground)
    }
    
    func reset() {
        withAnimation {
            vm.reset()
        }
    }
    
    func showResults() {
        vm.isControllerShowing = false
        vm.isValuesShowing = true
    }
}

#Preview {
    WindSideView()
}
