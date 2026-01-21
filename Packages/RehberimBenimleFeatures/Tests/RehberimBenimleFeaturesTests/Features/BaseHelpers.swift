//
//  BaseHelpers.swift
//  RehberimBenimleFeatures
//
//  Created by Okan Orkun on 20.01.2026.
//

import UIKit
import RehberimBenimleCoreKit


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
    var isSignupCalled = false
    var shouldReturnError = false
    
    func setShouldReturnError(_ value: Bool) {
        shouldReturnError = value
    }
    
    func getIsLoginCalled() -> Bool {
        return isLoginCalled
    }
    
    func getIsSignupCalled() -> Bool {
        return isSignupCalled
    }
    
    func login(email: String, password: String) async throws {
        isLoginCalled = true
        if shouldReturnError {
            throw LoginError.invalidCredentials
        }
    }
    
    func signup(role: String, fullName: String, email: String, password: String) async throws {
        isSignupCalled = true
        if shouldReturnError {
            throw SignupError.invalidCredentials
        }
    }
}
