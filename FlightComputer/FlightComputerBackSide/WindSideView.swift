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
    private var speedValue: CGFloat { 170 - verticalOffset / unitHeight }
    
    @State var markOffset: CGFloat = 0
    private var markValue: CGFloat { -markOffset / unitHeight }
    var markDegree: Double { vm.wCACalculator.windDirection - rotation.degrees }
    
    @State var pan: CGOffset = .zero
    @GestureState var gesturePan: CGOffset = .zero
    private var totalPan: CGOffset { pan + gesturePan }
    
    private var unitHeight: CGFloat { vm.unitHeight }
    
    //MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                windSideComponents
                controllerButtons
                values.opacity(isValuesShowing ? 1 : 0)
            }
            .simultaneousGesture(
                panGesture
            )
            .simultaneousGesture(
                magnifyGesture
            )
            .sheet(isPresented: $isControllerShowing) {
                controllerView
                    .padding()
                    .presentationDetents([.medium, .fraction(0.3)])
            }
            .onAppear {
                vm.screenWidth = geometry.size.width
            }
            .onChange(of: step) { oldValue, newValue in
                handleStepChange(newValue: newValue)
            }
        }
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
            .offset(y: (vm.wCACalculator.headWind ?? 0) * unitHeight)
        }
        // Enables users to move and scale content for better inspection.
        .offset(totalPan)
        .scaleEffect(totalScale)
    }
    
    var windSideBackground: some View {
        Image("windsidebackground")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    var windSideStator: some View {
        Image("windsiderotorouter")
            .resizable()
            .aspectRatio(5.1 / 10, contentMode: .fill)
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
    
    //MARK: Sliders
    var verticalSlider: some View {
        VStack{
            Slider(value: $verticalOffset, in: vm.verticalRange, step: unitHeight)
            Stepper(value: $verticalOffset, in: vm.verticalRange, step: unitHeight) {
                HStack {
                    Text("True Air Speed: ")
                    TextField("Enter a number", text: verticalFormattedBinding)
                }
            }
        }
    }
    
    private var verticalFormattedBinding: Binding<String> {
        Binding(
            get: { String(format: "%.2f", speedValue) },
            set: { newValue in
                if let value = Double(newValue),
                   vm.isVerticalOffsetInRange(value: value){
                    verticalOffset = vm.calculateVerticalOffset(value: value)
                }
            }
        )
    }
    
    var markSlider: some View {
        VStack{
            Slider(value: $markOffset, in: vm.markRange, step: unitHeight)
            Stepper(value: $markOffset, in: vm.markRange, step: unitHeight) {
                HStack {
                    Text("Wind speed: ")
                    TextField("Enter a number", text: markFormattedBinding)
                }
            }
        }
    }
    
    private var markFormattedBinding: Binding<String> {
        Binding(
            get: { String(format: "%.2f", abs(markValue)) },
            set: { newValue in
                if let value = Double(newValue),
                   vm.isMarkInRange(value: value)
                {
                    markOffset = vm.calculateMarkOffset(value: value)
                }
            }
        )
    }
    
    var angleSlider: some View {
        VStack {
            Slider(value: $rotation.degrees, in: 0...360, step: 1)
            
            Stepper(value: $rotation.degrees, in: 0...360, step: 1) {
                HStack {
                    Text(step == .windDirection ? "Wind Direction:" : "True Course:")
                    TextField("Enter a number", text: angleFormattedBinding)
                }
            }
        }
    }
    
    private var angleFormattedBinding: Binding<String> {
        Binding(
            get: { String(format: "%.0f°", rotation.degrees) },
            set: { newValue in
                if let value = Double(newValue), vm.isAngleInRange(value: value) {
                    rotation.degrees = value
                }
            }
        )
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
            case .trueCourse, .windDirection: angleSlider
            case .windVelocity: markSlider
            case .trueAirSpeed: verticalSlider
            case .result: EmptyView()
            }
            HStack {
                backButton
                nextButton
            }
        }
    }
    
    //MARK: Controller buttons
    var controllerButtons: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()
                HStack {
                    setValuesButton
                    toggleValuesButton
                }
                .foregroundStyle(.blue.gradient)
                .frame(height: 50)
                .padding()
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 50)
                }
            }
        }
    }
    
    private var setValuesButton: some View {
        Button {
            isControllerShowing.toggle()
        } label: {
            UnevenRoundedRectangle(topLeadingRadius: 15, bottomLeadingRadius: 15)
                .overlay {
                    Text("Set Values")
                        .foregroundStyle(.white)
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
                        .foregroundStyle(.white)
                }
        }
    }
        
    private var nextButton: some View {
        Button {
            vm.setValue(for: step, speedValue: Double(speedValue), markValue: Double(markValue), angle: rotation.degrees)
            step.next()
        } label: {
            Text("Next")
                .foregroundStyle(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.green.gradient)
                )
            }
    }
    
    private var backButton: some View {
        Button {
            step.back()
        } label: {
            Text("Back")
                .foregroundStyle(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.red.gradient)
                )
            }
    }
    
    //MARK: Functions
    private func centerView() {
        pan = .zero
        scale = 1
    }
    
    private func handleStepChange(newValue: WCACalculationSteps) {
        if newValue == .result {
            isValuesShowing.toggle()
            isControllerShowing.toggle()
        }
    }
}

#Preview {
    WindSideView()
}
