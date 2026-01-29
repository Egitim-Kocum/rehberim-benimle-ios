//
//  SignupPresenterTests.swift
//  RehberimBenimleFeatures
//
//  Created by Okan Orkun on 20.01.2026.
//

import Testing
import Foundation
@testable import RehberimBenimleFeatures

@Suite("Signup Presenter Tests")
@MainActor
struct SignupPresenterTests {
    private let presenter: SignupPresenter
    private let interactor: MockSignupInteractor
    private let router: MockSignupRouter
    private let view: MockSignupView
    private let validator: MockSignupValidator
    
    init() {
        self.interactor = MockSignupInteractor()
        self.router = MockSignupRouter()
        self.view = MockSignupView()
        self.validator = MockSignupValidator()
        
        self.presenter = SignupPresenter(
            interactor: interactor,
            router: router,
            validator: validator
        )
        self.presenter.view = view
    }
    
    @Test("SignupPresenter validateEmail success renders success state")
    func test_SignupPresenter_validateEmail_whenValidEmail_rendersSuccess() {
        // When
        presenter.validateEmail("test@mail.com")

        // Then
        if case .success = view.emailState {
            #expect(true)
        } else {
            Issue.record("Expected email validation to succeed")
        }
    }
    
    @Test("SignupPresenter validateEmail error renders error state")
    func test_SignupPresenter_validateEmail_whenInvalidEmail_rendersError() {
        // When
        presenter.validateEmail("invalid-mail")

        // Then
        if case .error = view.emailState {
            #expect(true)
        } else {
            Issue.record("Expected email validation error")
        }
    }
    
    @Test("SignupPresenter validateConfirmPassword mismatch renders error")
    func test_SignupPresenter_validateConfirmPassword_whenPasswordsDoNotMatch_rendersError() {
        // When
        presenter.validateConfirmPassword(
            password: "123456",
            confirmPassword: "123"
        )

        // Then
        if case .error = view.confirmPasswordState {
            #expect(true)
        } else {
            Issue.record("Expected confirm password validation error")
        }
    }

    
    @Test("Should not call interactor and should render error when validation fails")
    func test_SignupPresenter_signupButtonTapped_whenValidationFails_rendersError() async {
        // Given
        validator.shouldValidationFail = true
        
        // When
        await presenter.signupButtonTapped(role: nil, fullName: nil, email: nil, password: nil, confirmPassword: nil)
        
        // Then
        let result = await interactor.getIsSignupCalled()
        #expect(result == false)
        if case .error = view.lastRenderedState {
            #expect(true)
        } else {
            Issue.record("Expected view to render an error state")
        }
    }
    
    @Test("Should render error when interactor returns an error")
    func test_SignupPresenter_signupButtonTapped_whenInteractorFails_rendersError() async {
        // Given
        await interactor.setShouldReturnError(true)
        
        // When
        await presenter.signupButtonTapped(
            role: .student,
            fullName: "Okan",
            email: "valid@mail.com",
            password: "123",
            confirmPassword: "123"
        )
        
        // Then
        let result = await interactor.getIsSignupCalled()
        #expect(result == true)
        #expect(router.didNavigateToLogin == false)

        if case .error = view.lastRenderedState {
            #expect(true)
        } else {
            Issue.record("Expected view to render an error state")
        }
    }
    
    @Test("Should render success and navigate to infos when interactor is successful")
    func test_SignupPresenter_signupButtonTapped_whenSuccess_rendersSuccessAndNavigates() async {
        // Given
        await interactor.setShouldReturnError(false)
        
        // When
        await presenter.signupButtonTapped(
            role: .student,
            fullName: "Okan",
            email: "valid@mail.com",
            password: "123",
            confirmPassword: "123"
        )
        
        // Then
        let result = await interactor.getIsSignupCalled()
        #expect(result == true)
        #expect(router.didNavigateToLogin == true)
        
        if case .success = view.lastRenderedState {
            #expect(true)
        } else {
            Issue.record("Expected view to render a success state")
        }
    }
    
    @Test("Should navigate to forgot password screen when forgot password is tapped")
    func test_SignupPresenter_alreadyHaveAccountTapped_navigates() {
        // When
        presenter.alreadyHaveAccountTapped()
        
        // Then
        #expect(router.didNavigateToLogin == true)
    }
}
