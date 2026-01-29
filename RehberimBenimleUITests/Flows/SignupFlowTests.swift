//
//  SignupFlowTests.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 21.01.2026.
//

import XCTest
import RehberimBenimleFeatures
import RehberimBenimleUI

final class StudentSignupFlowTests: BaseUITestCase {
    
    func test_StudentSignupView_signup_withValidCredentials_navigatesToLogin() {
        // Given
        let signupScreen = SignupScreen(app: app)
        
        // When
        signupScreen.signUp(
            role: UserType.student.title,
            fullName: "Okan",
            email: "test@test.com",
            password: "123456",
            confirmPassword: "123456"
        )
        
        let loginView = app.otherElements[LoginAccessibilityID.viewId]
        XCTAssertTrue(loginView.waitForExistence(timeout: 2))
    }
    
    func test_StudentSignupView_signup_withInvalidCredentials_showsError() {
        // Given
        let signupScreen = SignupScreen(app: app)
        
        // When
        signupScreen.signUp(
            role: UserType.student.title,
            fullName: "Okan",
            email: "invalid-mail",
            password: "123456",
            confirmPassword: "123456"
        )
        
        // Then
        let errorAlert = app.alerts["Hata"]
        XCTAssertTrue(
            errorAlert.waitForExistence(timeout: 2),
            "Expected error alert to appear for invalid credentials"
        )
    }
    
    func test_StudentSignupView_signup_withEmptyFields_showsValidationError() {
        // Given
        let signupScreen = SignupScreen(app: app)
        
        // When
        signupScreen.signUp(
            role: UserType.instructor.title,
            fullName: "",
            email: "",
            password: "",
            confirmPassword: ""
        )
        
        // Then
        let errorAlert = app.alerts["Hata"]
        XCTAssertTrue(
            errorAlert.waitForExistence(timeout: 2),
            "Expected validation error when credentials are empty"
        )
    }
    
    func test_StudentSignupView_signup_withWhitespaceFields_showsValidationError() {
        // Given
        let signupScreen = SignupScreen(app: app)
        
        // When
        signupScreen.signUp(
            role: UserType.student.title,
            fullName: "   ",
            email: "   ",
            password: "   ",
            confirmPassword: "   "
        )
        
        // Then
        let errorAlert = app.alerts["Hata"]
        XCTAssertTrue(
            errorAlert.waitForExistence(timeout: 2),
            "Expected validation error when credentials are empty"
        )
    }
    
    func test_StudentSignupView_tapAlreadyHaveAccountLink_navigatesToLoginView() {
        // Given
        let signupScreen = SignupScreen(app: app)
        
        // When
        signupScreen.tapAlreadyHaveAccountButton()
        
        let loginScreen = app.otherElements[LoginAccessibilityID.viewId]
        
        XCTAssertTrue(loginScreen.waitForExistence(timeout: 2))
    }
}
