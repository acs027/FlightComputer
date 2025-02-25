//
//  WindSideView.swift
//  FlightComputer
//
//  Created by ali cihan on 15.02.2025.
//

import SwiftUI

struct WindSideView: View {
    @State var vm = WindSideViewModel()
    @State var step: WCACalculationSteps = .windDirection
    @State var rotation: Angle = Angle(degrees: 0)
    @State var isControllerShowing = false
    @State var isValuesShowing = false
    
    @State var scale: CGFloat = 1
    @GestureState var gestureScale: CGFloat = 1
    private var totalScale: CGFloat { scale * gestureScale }
    
    @State var verticalOffset: CGFloat = 0
    private var speedValue: CGFloat { 170 - verticalOffset / vm.unitHeight }
    
    @State var markOffset: CGFloat = 0
    private var markValue: CGFloat { -markOffset / vm.unitHeight }
    var markDegree: Double { vm.wCACalculator.windDirection - rotation.degrees }
    
    @State var pan: CGOffset = .zero
    @GestureState var gesturePan: CGOffset = .zero
    private var totalPan: CGOffset { pan + gesturePan }
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .center) {
            windSideComponents
            controllerButtons
            values.opacity(isValuesShowing ? 1 : 0)
                .padding()
        }
        .background(Constants.bgColor)
        .simultaneousGesture(
            panGesture
        )
        .simultaneousGesture(
            magnifyGesture
        )
        .sheet(isPresented: $isControllerShowing) {
            controllerView
                .padding()
                .presentationBackground(Constants.sheetBg)
                .presentationDetents([.medium, .fraction(0.3)])
        }
        .onChange(of: step) { oldValue, newValue in
            handleStepChange(newValue: newValue)
        }
    }
    
    //MARK: Constants
    struct Constants {
        static let bgColor: Color = Color(.systemGroupedBackground)
        static let controllerViewFgColor: Color = .primary
        static let mainButtonColor: AnyGradient = Color.blue.gradient
        static let buttonTextColor: Color = Color(.tertiarySystemBackground)
        static let nextButtonColor: AnyGradient = Color.green.gradient
        static let backButtonColor: AnyGradient = Color.red.gradient
        static let sheetBg: Color = Color(.systemGroupedBackground)
        static let centerButtonBgColor: Color = Color(.systemBackground)
    }
    
    //MARK: Main components
    var windSideComponents: some View {
        Group{
            windSideBackground
            Group{
                windSideStator
                windSideRotor
                markOnRotor
            }
            // Adding Headwind speed to True Air Speed
            .offset(y: (vm.wCACalculator.headWind ?? 0) * vm.unitHeight)
        }
        // Enables users to move and scale content for better inspection.
        .offset(totalPan)
        .scaleEffect(totalScale)
    }
    
    var windSideBackground: some View {
        GeometryReader { geometry in
            Image("windsidebackground")
                .resizable()
                .scaledToFit()
                .frame(width: geometry.size.width)
                .preference(key: HeightSizeKey.self, value: geometry.size.height)
        }
        .onPreferenceChange(HeightSizeKey.self) { newValue in
            DispatchQueue.main.async{
                let threshold: CGFloat = 1.0
                if abs(vm.referenceHeight - newValue) > threshold {
                    vm.referenceHeight = newValue
                }
            }
        }
    }
    
    var windSideStator: some View {
        Image("windsiderotorouter")
            .resizable()
            .scaledToFit()
            .offset(y: verticalOffset)
    }
    
    var windSideRotor: some View {
        Image("windsiderotor")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .offset(x: sin(-rotation.radians) * verticalOffset , y: cos(-rotation.radians) * verticalOffset)
            .rotationEffect(-rotation)
    }
    
    var markOnRotor: some View {
        Group {
            Circle()
                .frame(width: 10)
                .offset(y: markOffset)
                .rotationEffect(Angle(degrees: markDegree))
        }
        .offset(y: verticalOffset)
    }
    
    private var values: some View {
        ZStack(alignment: .topLeading) {
            Color.clear
            VStack(alignment: .leading) {
                ForEach(vm.results, id: \.label) { result in
                    ResultTextView(label: result.label, value: result.value, valueType: result.type)
                }
            }
        }
    }
    
    //MARK: Gestures
    var panGesture: some Gesture {
        DragGesture()
            .updating($gesturePan) { value, state, _ in
                state = value.translation
            }
            .onEnded({ value in
                pan += value.translation
            })
    }
    
    var magnifyGesture: some Gesture {
        MagnifyGesture()
            .updating($gestureScale) { value, state, _ in
                state = value.magnification
            }
            .onEnded({ value in
                scale *= value.magnification
            })
    }
    
    // MARK: Controller View
    @ViewBuilder
    var controllerView: some View {
        VStack {
            switch step {
            case .trueCourse, .windDirection: WindSideAngleSlider(vm: vm, rotation: $rotation, step: step)
            case .windVelocity: WindSideWindSpeedSlider(vm: vm, markOffset: $markOffset, markValue: markValue)
            case .trueAirSpeed: WindSideTASSlider(vm: vm, verticalOffset: $verticalOffset, speedValue: speedValue)
            case .result: EmptyView()
            }
            HStack {
                backButton
                nextButton
            }
        }
        .foregroundStyle(Constants.controllerViewFgColor)
    }
    
    //MARK: Controller buttons
    var controllerButtons: some View {
        VStack {
            HStack {
                Spacer()
                centerButton
            }
            .padding()
            Spacer()
            HStack {
                setValuesButton
                toggleValuesButton
            }
            .foregroundStyle(Constants.mainButtonColor)
            .frame(height: 50)
        }
        .padding()
    }
    
    private var centerButton: some View {
        Button {
            centerView()
        } label: {
            Image(systemName: "scope")
                .font(.largeTitle)
                .background(
                    Circle()
                        .tint(Constants.centerButtonBgColor)
                )
        }
    }
    
    private var setValuesButton: some View {
        Button {
            isControllerShowing.toggle()
        } label: {
            UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 15)
                .overlay {
                    Text("Set Values")
                        .foregroundStyle(Constants.buttonTextColor)
                }
        }
    }
    
    private var toggleValuesButton: some View {
        Button {
            isValuesShowing.toggle()
        } label: {
            UnevenRoundedRectangle(bottomTrailingRadius: 15, topTrailingRadius: 15)
                .overlay {
                    Text("Toggle Values")
                        .foregroundStyle(Constants.buttonTextColor)
                }
        }
    }
    
    private var nextButton: some View {
        Button {
            vm.setValue(for: step, speedValue: Double(speedValue), markValue: Double(markValue), angle: rotation.degrees)
            step.next()
        } label: {
            Text("Next")
                .foregroundStyle(Constants.buttonTextColor)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Constants.nextButtonColor)
                )
        }
    }
    
    private var backButton: some View {
        Button {
            step.back()
        } label: {
            Text("Back")
                .foregroundStyle(Constants.buttonTextColor)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Constants.backButtonColor)
                )
        }
    }
    
    struct HeightSizeKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
    
    //MARK: Functions
    private func centerView() {
        pan = .zero
//        scale = 1
        print(UIScreen.main.bounds.height)
    }
    
    private func handleStepChange(newValue: WCACalculationSteps) {
        if newValue == .result {
            isValuesShowing = true
            isControllerShowing = false
        }
    }
}

#Preview {
    WindSideView()
}
