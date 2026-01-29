//
//  LoginInteractor.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import Foundation
import RehberimBenimleCoreKit

final actor LoginInteractor: LoginInteractorProtocol {
    
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    func login(email: String, password: String) async throws -> AuthResponse {
        return try await authService.login(email: email, password: password)
    }
}
