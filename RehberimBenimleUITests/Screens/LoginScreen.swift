//
//  LoginScreen.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 25.12.2025.
//

import XCTest
import RehberimBenimleFeatures

final class LoginScreen: BaseScreen {

    var emailField: XCUIElement {
        app.textFields[LoginAccessibilityID.emailTextField]
    }

    var passwordField: XCUIElement {
        app.secureTextFields[LoginAccessibilityID.passwordTextField]
    }

    var loginButton: XCUIElement {
        app.buttons[LoginAccessibilityID.loginButton]
    }

    var forgotPasswordButton: XCUIElement {
        app.buttons[LoginAccessibilityID.forgotPasswordButton]
    }

    func login(email: String, password: String) {
        typeText(email, into: emailField)
        typeText(password, into: passwordField)
        tap(loginButton)
    }
    
    func tapForgotPassword() {
        tap(forgotPasswordButton)
    }
}

