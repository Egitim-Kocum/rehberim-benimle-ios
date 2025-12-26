//
//  LoginRouterTests.swift
//  RehberimBenimleTests
//
//  Created by Okan Orkun on 24.12.2025.
//

import Testing
import UIKit
@testable import RehberimBenimle

@Suite("LoginRouter Tests")
@MainActor
struct LoginRouterTests {

    private let router: LoginRouter
    private let navigationController: MockNavigationController
    private let rootViewController: UIViewController
    
    init() {
        self.router = LoginRouter()
        self.rootViewController = UIViewController()
        self.navigationController = MockNavigationController(rootViewController: rootViewController)
        
        self.router.viewController = rootViewController
    }
    
    // TODO: This will be implemented after Home and Forgot Password screens
}
