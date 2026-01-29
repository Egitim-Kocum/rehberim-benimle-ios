//
//  AuthResponse.swift
//  RehberimBenimleCoreKit
//
//  Created by Okan Orkun on 22.01.2026.
//

public struct AuthResponse: Sendable {
    public let role: String
    public let isProfileCompleted: Bool
    
    public init(role: String, isProfileCompleted: Bool) {
        self.role = role
        self.isProfileCompleted = isProfileCompleted
    }
}
