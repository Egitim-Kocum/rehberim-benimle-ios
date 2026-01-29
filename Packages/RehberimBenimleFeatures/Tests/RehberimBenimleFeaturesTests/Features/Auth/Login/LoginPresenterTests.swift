//
//  LoginPresenterTests.swift
//  RehberimBenimleTests
//
//  Created by Okan Orkun on 24.12.2025.
//

import Testing
import Foundation
@testable import RehberimBenimleFeatures

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
        
        // When
        await presenter.loginButtonTapped(email: nil, password: nil)
        
        // Then
        let result = await interactor.getIsLoginCalled()
        #expect(result == false)
        if case .error = view.lastRenderedState {
            #expect(true)
        } else {
            Issue.record("Expected view to render an error state")
        }
    }
    
    @Test("Should render error when interactor returns an error")
    func test_LoginPresenter_loginButtonTapped_whenInteractorFails_rendersError() async {
        // Given
        await interactor.setShouldReturnError(true)
        
        // When
        await presenter.loginButtonTapped(email: "valid@mail.com", password: "123")
        
        // Then
        let result = await interactor.getIsLoginCalled()
        #expect(result == true)
        #expect(router.didNavigateToHome == false)
        #expect(router.didNavigateToInfos == false)

        if case .error = view.lastRenderedState {
            #expect(true)
        } else {
            Issue.record("Expected view to render an error state")
        }
    }
    
    @Test("Should render success and navigate to home when interactor is successful")
    func test_LoginPresenter_loginButtonTapped_whenSuccess_rendersSuccess_navigatesInfos() async {
        // Given
        await interactor.setShouldReturnError(false)
        await interactor.setIsProfileCompleted(false)
        
        // When
        await presenter.loginButtonTapped(email: "test@mail.com", password: "123")
        
        // Then
        let result = await interactor.getIsLoginCalled()
        #expect(result == true)
        #expect(router.didNavigateToInfos == true)
        #expect(router.didNavigateToHome == false)
        
        if case .success = view.lastRenderedState {
            #expect(true)
        } else {
            Issue.record("Expected view to render a success state")
        }
    }
    
    @Test("Should render success and navigate to home when interactor is successful")
    func test_LoginPresenter_loginButtonTapped_whenSuccess_rendersSuccess_navigatesHome() async {
        // Given
        await interactor.setShouldReturnError(false)
        await interactor.setIsProfileCompleted(true)
        
        // When
        await presenter.loginButtonTapped(email: "test@mail.com", password: "123")
        
        // Then
        let result = await interactor.getIsLoginCalled()
        #expect(result == true)
        #expect(router.didNavigateToInfos == false)
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
