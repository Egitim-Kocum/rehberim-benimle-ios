//
//  LoginInteractor.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import Foundation

final class LoginInteractor: LoginInteractorProtocol {
    
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    func login(email: String, password: String) async throws {
        try await authService.login(email: email, password: password)
    }
}

// TODO: Mock Logic for now
enum LoginError: LocalizedError {
    case invalidCredentials
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Geçersiz email veya şifre."
        }
    }
}

protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws
}

final class MockAuthService: AuthServiceProtocol {
    func login(email: String, password: String) async throws {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        
        // Mock validation - gelecekte gerçek API'den gelecek
        if email == "test@test.com" && password == "123456" {
            return
        }
        throw LoginError.invalidCredentials
    }
}

final class AuthService: AuthServiceProtocol {
    func login(email: String, password: String) async throws {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        
        // Mock validation - gelecekte gerçek API'den gelecek
        if email == "test@test.com" && password == "123456" {
            return
        }
        throw LoginError.invalidCredentials
    }
}
