//
//  AuthServiceProtocol.swift
//  RehberimBenimleCoreKit
//
//  Created by Okan Orkun on 31.12.2025.
//

public protocol AuthServiceProtocol: Sendable {
    func login(email: String, password: String) async throws
    func signup(role: String, fullName: String, email: String, password: String) async throws
}
