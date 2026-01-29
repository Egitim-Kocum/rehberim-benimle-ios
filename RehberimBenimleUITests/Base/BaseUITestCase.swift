//
//  BaseUITestCase.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 25.12.2025.
//

import XCTest

class BaseUITestCase: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("--ui-testing")
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func tap(_ element: XCUIElement) {
        XCTAssertTrue(
            element.waitForExistence(timeout: 2),
            "Expected element to exist before tapping"
        )
        element.tap()
    }
}
