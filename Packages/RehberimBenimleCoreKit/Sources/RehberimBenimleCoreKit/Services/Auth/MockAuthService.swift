//
//  MockAuthService.swift
//  RehberimBenimleCoreKit
//
//  Created by Okan Orkun on 31.12.2025.
//

public final actor MockAuthService: AuthServiceProtocol {
    public func login(email: String, password: String) async throws {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        
        // Mock validation - gelecekte gerçek API'den gelecek
        if email == "test@test.com" && password == "123456" {
            return
        }
        throw LoginError.invalidCredentials
    }
}
