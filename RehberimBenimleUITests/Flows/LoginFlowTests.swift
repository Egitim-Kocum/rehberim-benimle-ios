//
//  LoginFlowTests.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 25.12.2025.
//

import XCTest
import RehberimBenimleFeatures

final class LoginFlowTests: BaseUITestCase {

    func test_LoginView_login_withValidCredentials_navigatesToHome() {
        // Given
        let loginScreen = LoginScreen(app: app)

        // When
        loginScreen.login(
            email: "test@test.com",
            password: "123456"
        )

        // Then
        // TODO: Implement HomeView and assign accessibilityIdentifier
        // Once implemented, replace this assertion with:
        // let homeView = app.otherElements["HomeView"]
        // XCTAssertTrue(homeView.waitForExistence(timeout: 2))

    }

    func test_LoginView_login_withInvalidCredentials_showsError() {
        // Given
        let loginScreen = LoginScreen(app: app)

        // When
        loginScreen.login(
            email: "wrong@test.com",
            password: "wrongpass"
        )

        // Then
        let errorAlert = app.alerts["Error"]
        XCTAssertTrue(
            errorAlert.waitForExistence(timeout: 2),
            "Expected error alert to appear for invalid credentials"
        )
    }

    func test_LoginView_login_withEmptyFields_showsValidationError() {
        // Given
        let loginScreen = LoginScreen(app: app)

        // When
        loginScreen.login(email: "", password: "")

        // Then
        let errorAlert = app.alerts["Error"]
        XCTAssertTrue(
            errorAlert.waitForExistence(timeout: 2),
            "Expected validation error when credentials are empty"
        )
    }
    
    func test_LoginView_login_withWhitespaceFields_showsValidationError() {
        // Given
        let loginScreen = LoginScreen(app: app)

        // When
        loginScreen.login(email: "   ", password: "   ")

        // Then
        let errorAlert = app.alerts["Error"]
        XCTAssertTrue(
            errorAlert.waitForExistence(timeout: 2),
            "Expected validation error when credentials are empty"
        )
    }

    func test_LoginView_tapForgotPassword_navigatesToForgotPassword() {
        // Given
        let loginScreen = LoginScreen(app: app)

        // When
        loginScreen.tapForgotPassword()

        // Then
        // TODO: Implement ForgotPasswordView and assign accessibilityIdentifier
        // Once implemented, replace this assertion with:
        // let forgotPasswordView = app.otherElements["ForgotPasswordView"]
        // XCTAssertTrue(forgotPasswordView.waitForExistence(timeout: 2))

    }
}
