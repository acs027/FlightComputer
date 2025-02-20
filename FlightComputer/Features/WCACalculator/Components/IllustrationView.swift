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
            compass
            windArrow
            courseArrow
            tasArrow
            topLeadingInfos
            topTrailingInfos
            bottomLeadingInfos
        }
    }
    
    //MARK: - Constants
    private struct Constants {
        static let markSize: CGFloat = 20
        struct ArrowColor {
            static let first: Color = .red
            static let second: Color = .blue
            static let third: Color = .green
        }
    }
    
    //MARK: - Components
    var topLeadingInfos: some View {
        VStack(alignment: .leading) {
            windInfo
            wcaInfo
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding()
    }
    
    var topTrailingInfos: some View {
        VStack(alignment: .leading) {
            courseInfo
            headingInfo
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
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
        .foregroundStyle(.gray)
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
                        .onAppear {
                            vm.circleRadius = geometry.size.width
                            print(vm.circleRadius)
                        }
                }
                .aspectRatio(1, contentMode: .fit)
                Text("S")
            }
            Text("E")
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

#Preview {
    @Previewable @State var vm = WindCorrectionViewModel()
    IllustrationView(vm: vm)
}
