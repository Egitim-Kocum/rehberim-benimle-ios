//
//  LoginPresenterTests.swift
//  RehberimBenimleTests
//
//  Created by Okan Orkun on 24.12.2025.
//

import Testing
import Foundation
@testable import RehberimBenimle

@Suite("Login Presenter Tests")
@MainActor
struct LoginPresenterTests {
    
    private let presenter: LoginPresenter
    private let interactor: MockLoginInteractor
    private let router: MockLoginRouter
    private let view: MockLoginView
    private let validator: MockLoginValidator
    
    init() {
        self.interactor = MockLoginInteractor()
        self.router = MockLoginRouter()
        self.view = MockLoginView()
        self.validator = MockLoginValidator()
        
        self.presenter = LoginPresenter(interactor: interactor, router: router, validator: validator)
        self.presenter.view = view
    }
    
    @Test("Should not call interactor and should render error when validation fails")
    func test_LoginPresenter_loginButtonTapped_whenValidationFails_rendersError() async {
        // Given
        validator.shouldValidationFail = true
        
        // When - await bittiğinde catch bloğu çalışmış olacak
        await presenter.loginButtonTapped(email: nil, password: nil)
        
        // Then
        #expect(interactor.isLoginCalled == false)
        if case .error = view.lastRenderedState {
            #expect(true)
        } else {
            Issue.record("Expected view to render an error state")
        }
    }
    
    @Test("Should render error when interactor returns an error")
    func test_LoginPresenter_loginButtonTapped_whenInteractorFails_rendersError() async {
        // Given
        interactor.shouldReturnError = true
        
        // When - await bittiğinde interactor hatası yakalanmış olacak
        await presenter.loginButtonTapped(email: "valid@mail.com", password: "123")
        
        // Then
        #expect(interactor.isLoginCalled == true)
        #expect(router.didNavigateToHome == false)

        if case .error = view.lastRenderedState {
            #expect(true)
        } else {
            Issue.record("Expected view to render an error state")
        }
    }
    
    @Test("Should render success and navigate to home when interactor is successful")
    func test_LoginPresenter_loginButtonTapped_whenSuccess_rendersSuccessAndNavigates() async {
        // Given
        interactor.shouldReturnError = false
        
        // When - await bittiğinde tüm akış (loading -> success -> navigate) tamamlanmış olacak
        await presenter.loginButtonTapped(email: "test@mail.com", password: "123")
        
        // Then
        #expect(interactor.isLoginCalled == true)
        #expect(router.didNavigateToHome == true)
        
        if case .success = view.lastRenderedState {
            #expect(true)
        } else {
            Issue.record("Expected view to render a success state")
        }
    }
    
    @Test("Should navigate to forgot password screen when forgot password is tapped")
    func test_LoginPresenter_forgotPasswordTapped_navigates() {
        // When
        presenter.forgotPasswordTapped()
        
        // Then
        #expect(router.didNavigateToForgotPassword == true)
    }
}
