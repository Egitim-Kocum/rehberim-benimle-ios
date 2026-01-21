//
//  SignupTestHelpers.swift
//  RehberimBenimleFeatures
//
//  Created by Okan Orkun on 20.01.2026.
//

import RehberimBenimleCoreKit
import RehberimBenimleUI
@testable import RehberimBenimleFeatures

// MARK: - Mock View
@MainActor
final class MockSignupView: SignupViewControllerProtocol {
    var lastRenderedState: LoadingState?
    
    func render(state: LoadingState) {
        lastRenderedState = state
    }
}

// MARK: - Mock Login Validator
final class MockSignupValidator: SignupValidatorProtocol {
    var shouldValidationFail = false
    
    func validate(role: UserType?, fullName: String?, email: String?, password: String?, confirmPassword: String?) throws -> (role: String, fullName: String, email: String, password: String) {
        if shouldValidationFail {
            throw ValidationError.invalidEmail
        }
        return (role?.itemTitle ?? UserType.notSelected.itemTitle, fullName ?? "", email ?? "", password ?? "")
    }
}

// MARK: - Mock Interactor
final actor MockSignupInteractor: SignupInteractorProtocol {
    var isSignupCalled = false
    var shouldReturnError = false
    
    func setShouldReturnError(_ value: Bool) {
        shouldReturnError = value
    }
    
    func getIsSignupCalled() -> Bool {
        return isSignupCalled
    }
    
    func signup(role: String, fullName: String, email: String, password: String) async throws {
        isSignupCalled = true
        if shouldReturnError {
            throw SignupError.invalidCredentials
        }
    }
}

// MARK: - Mock Router
final class MockSignupRouter: SignupRouterProtocol {
    var didNavigateToInfos = false
    var didNavigateToLogin = false
    
    func navigateToInfos() {
        didNavigateToInfos = true
    }
    
    func navigateToLogin() {
        didNavigateToLogin = true
    }
}
