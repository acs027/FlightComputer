//
//  WindCorrectionView.swift
//  FlightComputer
//
//  Created by ali cihan on 19.02.2025.
//

import SwiftUI

struct IllustrationView: View {
    @State var vm: WindCorrectionViewModel
    
    var body: some View {
        ZStack {
            Group {
                compass
                windArrow
                courseArrow
                tasArrow
            }.safeAreaInset(edge: .top) {
                Color.clear.frame(height: 10)
            }
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 10)
            }
            topLeadingInfos
            topTrailingInfos
            bottomLeadingInfos
            bottomTrailingInfos
        }
        .frame(maxWidth: 400, maxHeight: 400)
    }
    
    //MARK: - Constants
    private struct Constants {
        static let markSize: CGFloat = 20
        struct ArrowColor {
            static let first: Color = .blue
            static let second: Color = .gray
            static let third: Color = .mint
            static let four: Color = .green
        }
        static let compassColor: Color = .primary
    }
    
    //MARK: - Components
    var topTrailingInfos: some View {
        VStack(alignment: .leading) {
            windInfo
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding()
    }
    
    var topLeadingInfos: some View {
        VStack(alignment: .leading) {
            headingInfo
            courseInfo
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
    
    var bottomLeadingInfos: some View {
        VStack(alignment: .leading) {
            groundSpeedInfo
            trueAirSpeedInfo
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        .padding()
    }
    
    var bottomTrailingInfos: some View {
        VStack(alignment: .leading) {
            wcaInfo
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding()
    }
    
    
    var windInfo: some View {
        HStack {
            Rectangle()
                .frame(width: Constants.markSize, height: Constants.markSize)
            Text("Wind: ")
            Text("\(Int(vm.wCACalculator.windSpeed)) @ \(Int(vm.wCACalculator.windDirection))")
        }
        .foregroundStyle(Constants.ArrowColor.first)
    }
    
    var wcaInfo: some View {
        HStack {
            Rectangle()
                .frame(width: Constants.markSize, height: Constants.markSize)
            Text("WCA: ")
            Text(String(format: "%.0f", vm.wCACalculator.windCorrectionAngle ?? 0))
        }
        .foregroundStyle(Constants.ArrowColor.four)
    }
    
    var courseInfo: some View {
        HStack {
            Rectangle()
                .frame(width: Constants.markSize, height: Constants.markSize)
            Text("Course: ")
            Text("\(Int(vm.wCACalculator.trueCourse))")
        }
        .foregroundStyle(Constants.ArrowColor.second)
    }
    
    var headingInfo: some View {
        HStack {
            Rectangle()
                .frame(width: Constants.markSize, height: Constants.markSize)
            Text("Heading: ")
            Text(String(format: "%.0f", vm.wCACalculator.heading ?? 0))
        }
        .foregroundStyle(Constants.ArrowColor.third)
    }
    
    var groundSpeedInfo: some View {
        HStack {
            Rectangle()
                .frame(width: Constants.markSize, height: Constants.markSize)
            Text("GS: ")
            Text("\(Int(vm.wCACalculator.groundSpeed ?? 0))")
        }
        .foregroundStyle(Constants.ArrowColor.second)
    }
    
    var trueAirSpeedInfo: some View {
        HStack {
            Rectangle()
                .frame(width: Constants.markSize, height: Constants.markSize)
            Text("TAS: ")
            Text("\(Int(vm.wCACalculator.trueAirSpeed))")
        }
        .foregroundStyle(Constants.ArrowColor.third)
    }
    
    var compass: some View {
        HStack {
            Text("W")
            VStack {
                Text("N")
                GeometryReader { geometry in
                    Circle()
                        .stroke()
                        .aspectRatio(1, contentMode: .fit)
                        .preference(key: CircleSizeKey.self, value: geometry.size.width)
                }
                .aspectRatio(1, contentMode: .fit)
                Text("S")
            }
            Text("E")
        }
        .foregroundStyle(Constants.compassColor)
        .padding()
        .onPreferenceChange(CircleSizeKey.self) { newSize in
            DispatchQueue.main.async {
                   guard vm.circleRadius != newSize else { return }
                   vm.circleRadius = newSize
               }
        }
    }
    
    //MARK: - Arrows
    var windArrow: some View {
        // Wind
        Arrow()
            .fill(Constants.ArrowColor.first)
            .frame(width: 40, height: vm.windArrowHeight)
            .offset(y: vm.windArrowOffset)
            .rotationEffect(.degrees(vm.windArrowDegree))
    }
    
    var courseArrow: some View {
        //Ground Speed - Course
        Arrow()
            .fill(Constants.ArrowColor.second)
            .frame(width: 40, height: vm.courseArrowHeight)
            .offset(y: vm.courseArrowOffset) // Move arrow up to align its base to the center
            .rotationEffect(.degrees(vm.wCACalculator.trueCourse), anchor: .center)
    }
    
    var tasArrow: some View {
        // TAS - Heading
        Arrow()
            .fill(Constants.ArrowColor.third)
            .frame(width: 40, height: vm.tasArrowHeight)
            .offset(y: vm.tasArrowOffset) // Move arrow up to align its base to the center
            .rotationEffect(.degrees(vm.wCACalculator.heading ?? 0), anchor: .center)
    }
}

private struct CircleSizeKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    @Previewable @State var vm = WindCorrectionViewModel()
    IllustrationView(vm: vm)
}
