//
//  LoginInteractorTests.swift
//  RehberimBenimleTests
//
//  Created by Okan Orkun on 24.12.2025.
//

import Testing
@testable import RehberimBenimle

@Suite("LoginInteractor Tests")
struct LoginInteractorTests {
    
    private let interactor: LoginInteractor
    private let authService: MockAuthService
    
    init() {
        self.authService = MockAuthService()
        self.interactor = LoginInteractor(authService: authService)
    }
    
    @Test("Login successfully calls auth service with credentials")
    func test_LoginInteractor_login_callsAuthService_withCorrectParameters() async throws {
        // When
        try await interactor.login(email: "", password: "")
        
        // Then
        #expect(authService.isLoginCalled)
    }
    
    @Test("Login failed ")
    func test_LoginInteractor_login_invalidCredentials_returnError() async throws {
        authService.shouldReturnError = true
        
        do {
            try await interactor.login(email: "", password: "")
            Issue.record("Expected error but none thrown")
        } catch LoginError.invalidCredentials {

        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
}
