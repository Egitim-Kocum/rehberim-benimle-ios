//
//  LoginTestHelpers.swift
//  RehberimBenimleTests
//
//  Created by Okan Orkun on 24.12.2025.
//

import UIKit
import RehberimBenimleUI
import RehberimBenimleCoreKit
@testable import RehberimBenimleFeatures

// MARK: - Mock View
@MainActor
final class MockLoginView: LoginViewControllerProtocol {
    var lastRenderedState: LoadingState?
    
    func render(state: LoadingState) {
        lastRenderedState = state
    }
}

// MARK: - Mock Login Validator
final class MockLoginValidator: LoginValidatorProtocol {
    var shouldValidationFail = false
    
    func validate(email: String?, password: String?) throws -> (email: String, password: String) {
        if shouldValidationFail {
            throw ValidationError.invalidEmail
        }
        return (email ?? "", password ?? "")
    }
}

// MARK: - Mock Interactor
final actor MockLoginInteractor: LoginInteractorProtocol {
    var isLoginCalled = false
    var shouldReturnError = false
    
    func setShouldReturnError(_ value: Bool) {
        shouldReturnError = value
    }
    
    func getIsLoginCalled() -> Bool {
        return isLoginCalled
    }
    
    func login(email: String, password: String) async throws {
        isLoginCalled = true
        if shouldReturnError {
            throw LoginError.invalidCredentials
        }
    }
}

// MARK: - Mock Router
final class MockLoginRouter: LoginRouterProtocol {

    var didNavigateToHome = false
    var didNavigateToForgotPassword = false

    func navigateToHome() {
        didNavigateToHome = true
    }

    func navigateToForgotPassword() {
        didNavigateToForgotPassword = true
    }
}

// MARK: - Mock Navigation Controller
final class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

// MARK: - Mock Auth Service
final actor MockAuthService: AuthServiceProtocol {
    var isLoginCalled = false
    var shouldReturnError = false
    
    func setShouldReturnError(_ value: Bool) {
        shouldReturnError = value
    }
    
    func getIsLoginCalled() -> Bool {
        return isLoginCalled
    }
    
    func login(email: String, password: String) async throws {
        isLoginCalled = true
        if shouldReturnError {
            throw LoginError.invalidCredentials
        }
    }
}
