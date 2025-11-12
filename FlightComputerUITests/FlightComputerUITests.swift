//
//  FlightComputerUITests.swift
//  FlightComputerUITests
//
//  Created by ali cihan on 4.11.2025.
//

import XCTest

final class FlightComputerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testOnboardingAppearsFirstLaunch() throws {
        
        let app = XCUIApplication()
        app.setSeenOnboarding(false)
        app.launch()
         // Assumes you have an onboarding screen shown only on first launch
         let getStartedButton = app.buttons["Next"]
         XCTAssertTrue(getStartedButton.exists, "Get Started button should appear on onboarding screen")

//         getStartedButton.tap()
//
//         // After tapping, the main screen should appear
//         let mainTitle = app.staticTexts["Flight Computer"]
//         XCTAssertTrue(mainTitle.exists, "Main screen title should appear after onboarding")
     }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}

extension XCUIApplication {
    func setSeenOnboarding(_ seenOnboarding: Bool = true) {
        launchArguments += ["-hasSeenOnboarding", seenOnboarding ? "false" : "true" ]
    }
}
