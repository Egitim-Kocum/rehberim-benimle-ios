//
//  SignupScreen.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 21.01.2026.
//

import XCTest
import RehberimBenimleFeatures

final class SignupScreen: BaseScreen {
    
    var fullNameTextField: XCUIElement {
        app.textFields[SignupAccessibilityID.fullNameTextField]
    }
    
    var emailTextField: XCUIElement {
        app.textFields[SignupAccessibilityID.emailTextField]
    }
    
    var passwordTextField: XCUIElement {
        app.secureTextFields[SignupAccessibilityID.passwordTextField]
    }
    
    var confirmPasswordTextField: XCUIElement {
        app.secureTextFields[SignupAccessibilityID.confirmPasswordTextField]
    }
    
    var signUpButton: XCUIElement {
        app.buttons[SignupAccessibilityID.signUpButton]
    }
    
    var alreadyHaveAccountButton: XCUIElement {
        app.buttons[SignupAccessibilityID.alreadyHaveAccountButton]
    }
    
    func signUp(
        role: String,
        fullName: String,
        email: String,
        password: String,
        confirmPassword: String
    ) {
        selectSegment(role)
        typeText(fullName, into: fullNameTextField)
        typeText(email, into: emailTextField)
        typeText(password, into: passwordTextField)
        typeText(confirmPassword, into: confirmPasswordTextField)
        tap(signUpButton)
    }
    
    func tapAlreadyHaveAccountButton() {
        tap(alreadyHaveAccountButton)
    }
}
