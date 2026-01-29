//
//  SignupInteractorTests.swift
//  RehberimBenimleFeatures
//
//  Created by Okan Orkun on 20.01.2026.
//

import Testing
import RehberimBenimleCoreKit
import RehberimBenimleUI
@testable import RehberimBenimleFeatures

@Suite("Signup Interactor Tests")
struct SignupInteractorTests {
    
    private let interactor: SignupInteractor
    private let authService: MockAuthService
    
    init() {
        self.authService = MockAuthService()
        self.interactor = SignupInteractor(authService: authService)
    }
    
    @Test("Signup successfully calls auth service with credentials")
    func test_SignupInteractor_signup_callsAuthService_withCorrectParameters() async throws {
        // When
        try await interactor.signup(role: UserType.student.title, fullName: "Okan", email: "okan@mail.com", password: "123456")
        
        // Then
        #expect(await authService.getIsSignupCalled())
    }
    
    @Test("Signup failed ")
    func test_SignupInteractor_signup_invalidCredentials_returnError() async throws {
        await authService.setShouldReturnError(true)
        
        do {
            try await interactor.signup(role: UserType.student.title, fullName: "Okan", email: "okan@mail.com", password: "123456")
            Issue.record("Expected error but none thrown")
        } catch SignupError.invalidCredentials {

        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
}
