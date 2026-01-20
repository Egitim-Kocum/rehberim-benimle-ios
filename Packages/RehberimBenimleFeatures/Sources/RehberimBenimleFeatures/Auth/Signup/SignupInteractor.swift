//
//  SignupInteractor.swift
//  RehberimBenimleFeatures
//
//  Created by Okan Orkun on 19.01.2026.
//

import Foundation
import RehberimBenimleCoreKit

final actor SignupInteractor: SignupInteractorProtocol {
    
    private let authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func signup(role: String, fullName: String, email: String, password: String) async throws {
        try await authService.signup(role: role, fullName: fullName, email: email, password: password)
    }
}
