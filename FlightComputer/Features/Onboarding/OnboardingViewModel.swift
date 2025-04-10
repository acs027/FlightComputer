//
//  OnboardingViewModel.swift
//  FlightComputer
//
//  Created by ali cihan on 2.04.2025.
//

import Foundation


@Observable
class OnboardingViewModel {
    let pages: [OnboardingPage] = [
        OnboardingPage(image: "airplane", title: "Welcome to E6B Flight Computer", description: "Your all-in-one toolkit for mastering aviation calculations."),
        OnboardingPage(image: "wind", title: "Easily Calculate Wind Correction Angle", description: "Enter your known values, and our app will handle the calculations for you. Want a challenge? Try Pro Mode to use a virtual flight computer!"),
        OnboardingPage(image: "brain.fill", title: "Master the Flight Computer", description: "Our interactive E6B flight computer simulation lets you practice real-world aviation calculations, just like on a real device."),
        OnboardingPage(image: "books.vertical.fill", title: "Learn as You Go", description: "Step-by-step guides teach you how to use the flight computer to find wind correction angles and wind components."),
        OnboardingPage(image: "plus.forwardslash.minus", title: "Aviation Math Made Easy", description: "From fuel planning to altitude conversions, access quick calculators and unit converters tailored for pilots."),
        OnboardingPage(image: "airplane.departure", title: "You're All Set!", description: "Start exploring and improve your aviation skills with E6B Flight Computer. Happy flying!")
    ]
}
