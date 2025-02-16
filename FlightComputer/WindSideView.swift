//
//  WindSideView.swift
//  FlightComputer
//
//  Created by ali cihan on 15.02.2025.
//

import SwiftUI

enum WCACalculationSteps: String {
    case windDirection = "Place Wind Direction under True Index"
    case windVelocity = "Mark Wind Velocity up from the center point"
    case trueCourse = "Place True Course under True Index."
    case trueAirSpeed = "Slide Wind Velocity Mark to True Air Speed."
    case result = "Result"
    
    mutating func next() {
        switch self {
        case .windDirection:
            self = .windVelocity
        case .windVelocity:
            self = .trueCourse
        case .trueCourse:
            self = .trueAirSpeed
        case .trueAirSpeed:
            self = .result
        case .result:
            self = .windDirection
        }
    }
}

struct WindSideView: View {
    @State var viewModel = WindSideViewModel()
    var unitHeight: Float {
        let screenWidth = UIScreen.main.bounds.width
        let ratio: Float = 100 / 51
        let height = Float(screenWidth) * ratio * 0.83
        return height / 220
    }
    var verticalRange: ClosedRange<CGFloat> {
        let highestPoint = unitHeight * 130
        let lowestPoint = -unitHeight * 90
        return CGFloat(lowestPoint)...CGFloat(highestPoint)
    }
    
    var markRange: ClosedRange<CGFloat> {
        let highestPoint = 0
        let lowestPoint = -unitHeight * 50
        return CGFloat(lowestPoint)...CGFloat(highestPoint)
    }
    var speedValue: Float {
        170 - Float(verticalOffset) / unitHeight
    }
    
    var markValue: Float {
        Float(-markOffset) / unitHeight
    }
    
    @State var step: WCACalculationSteps = .windDirection
    
    @State var rotation: Angle = Angle(degrees: 0)
    
    @State var scale: CGFloat = 1
    @GestureState var gestureScale: CGFloat = 1
    
    @State var verticalOffset: CGFloat = 0
    
    @State var markOffset: CGFloat = 0
    
    @State var pan: CGOffset = .zero
    @GestureState var gesturePan: CGOffset = .zero
    
    @State var isControllerShowing = false
    
    var totalPan: CGOffset { pan + gesturePan }
    var totalScale: CGFloat { scale * gestureScale }
    
    var markDegree: Double {
        viewModel.wCACalculator.windDirection - rotation.degrees
    }
    
    var body: some View {
        
        ZStack(alignment: .center) {
            Group{
                windSideBackground
                windSideStator
                windSideRotor
                markOnRotor
            }
            .offset(totalPan)
            .scaleEffect(totalScale)
            centerViewButton
                .frame(alignment: .bottom)
                .padding()
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
    
    //MARK: Sliders
    var windVelocitySlider: some View {
        VStack{
            Slider(value: $verticalOffset, in: verticalRange, step: CGFloat(unitHeight))
            Stepper(value: $verticalOffset, in: verticalRange, step: CGFloat(unitHeight)) {
                HStack {
                    Text("Wind speed: ")
                    TextField("Enter a number", text: Binding(
                        get: { String(format: "%.2f", speedValue) },
                        set: { newValue in
                            if let value = Float(newValue),
                               verticalRange.contains(CGFloat((170 - value) * unitHeight)){
                                verticalOffset = CGFloat((170 - value) * unitHeight)
                            }
                        }
                    ))
                }
            }
        }
    }
    
    var markSlider: some View {
        VStack{
            Slider(value: $markOffset, in: markRange, step: CGFloat(unitHeight))
            Stepper(value: $markOffset, in: markRange, step: CGFloat(unitHeight)) {
                HStack {
                    Text("Wind speed: ")
                    TextField("Enter a number", text: Binding(
                        get: { String(format: "%.2f", markValue) },
                        set: { newValue in
                            if let value = Float(newValue),
                               markRange.contains(CGFloat(-value * unitHeight)){
                                markOffset = CGFloat(-value * unitHeight)
                            }
                        }
                    ))
                }
            }
        }
    }
    
    var angleSlider: some View {
        VStack {
            Slider(value: $rotation.degrees, in: 0...360, step: 1)
            Stepper(value: $rotation.degrees, in: 0...360, step: 1) {
                HStack {
                    Text("True course: ")
                    TextField("Enter a number", text: Binding(
                        get: { String(format: "%.2f", rotation.degrees) },
                        set: { newValue in
                            if let value = Double(newValue),
                               value >= 0,
                               value <= 360 {
                                rotation.degrees = value
                            }
                        }
                    ))
                }
            }
        }
    }
    
    
    var centerViewButton: some View {
        Button {
            isControllerShowing.toggle()
        } label: {
            Image(systemName: "inset.filled.center.rectangle.portrait")
                .resizable()
                .frame(width: 50, height: 80)
                .tint(.primary)
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
            case .trueCourse, .windDirection:
                angleSlider
            case .windVelocity:
                markSlider
            case .trueAirSpeed:
                windVelocitySlider
            case .result:
                EmptyView()
            }
            confirmButton
        }
    }
    
    var confirmButton: some View {
        Button {
            viewModel.setValue(for: step, speedValue: Double(speedValue), markValue: Double(markValue), angle: rotation.degrees)
            step.next()
        } label: {
            Text("Confirm")
        }
    }
    
    private func centerView() {
        pan = .zero
        scale = 1
    }
}

#Preview {
    WindSideView()
}
