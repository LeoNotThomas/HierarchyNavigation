//
//  HierarchyNavigationUITests.swift
//  HierarchyNavigationUITests
//
//  Created by Thomas Leonhardt on 29.06.22.
//

import XCTest
@testable import HierarchyNavigation

class HierarchyNavigationUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func launchApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launch()
        return app
    }
    
    private func checkExist(e: XCUIElement, timeout: TimeInterval = 2) {
        if !e.waitForExistence(timeout: timeout) {
            XCTFail("Can't find a expected element")
        }
        
    }

    func testNavigationAfterLink() throws {
        // UI tests must launch the application that they test.
        //TO DO: This test we should do against mocking data
        let app = launchApp()
        app.descendants(matching: .any)[Constant.AccessibilityIdentifier.menuButton].tap()
        app.staticTexts["Alter"].tap()
        app.staticTexts["Kindergarten"].tap()
        app.staticTexts["2-3 Jahre"].tap()
        app.descendants(matching: .any)[Constant.AccessibilityIdentifier.menuButton].tap()
        let toCheck = app.staticTexts["2-3 Jahre"]
        checkExist(e: toCheck)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
