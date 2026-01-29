//
//  SignupRouterTests.swift
//  RehberimBenimleFeatures
//
//  Created by Okan Orkun on 20.01.2026.
//

import Testing
import UIKit
@testable import RehberimBenimleFeatures

@Suite("Signup Router Tests")
@MainActor
struct SignupRouterTests {
    private let router: SignupRouter
    private let navigationController: MockNavigationController
    private let rootViewController: UIViewController
    
    init() {
        self.router = SignupRouter()
        self.rootViewController = UIViewController()
        self.navigationController = MockNavigationController(rootViewController: rootViewController)
        
        self.router.viewController = rootViewController
    }
    
    @Test("Should navigate to Login")
    func test_StudentSignupRouter_navigateToLogin_setsLoginViewController() {
        // When
        router.navigateToLogin()
        
        // Then
        #expect(navigationController.setViewControllersCalled == true)
        
        let rootVC = navigationController.lastSetViewControllers?.first
        #expect(rootVC is LoginViewController)
    }
    // TODO: This will be implemented after Infos screens
}
