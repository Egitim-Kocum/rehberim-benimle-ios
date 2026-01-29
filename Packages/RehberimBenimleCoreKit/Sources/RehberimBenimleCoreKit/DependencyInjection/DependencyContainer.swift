//
//  DependencyContainer.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 25.12.2025.
//

import Foundation

@MainActor
public final class DependencyContainer {

    public static let shared = DependencyContainer()

    private init() {}

    // MARK: - Environment

    private var isUITesting: Bool {
        ProcessInfo.processInfo.arguments.contains("--ui-testing")
    }

    // MARK: - Services

    public private(set) lazy var authService: AuthServiceProtocol = {
        if isUITesting {
            return MockAuthService()
        } else {
            return AuthService()
        }
    }()
}
