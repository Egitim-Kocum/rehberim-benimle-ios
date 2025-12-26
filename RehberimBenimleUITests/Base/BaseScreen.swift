//
//  BaseScreen.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 25.12.2025.
//

import XCTest

class BaseScreen {

    let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    // MARK: - Common Actions

    func tap(_ element: XCUIElement,
             timeout: TimeInterval = 2,
             file: StaticString = #file,
             line: UInt = #line) {
        
        XCTAssertTrue(
            element.waitForExistence(timeout: timeout),
            "Expected element to exist before tapping",
            file: file,
            line: line
        )
        element.tap()
    }

    func typeText(_ text: String, into element: XCUIElement) {
        tap(element)
        element.typeText(text)
    }
}
