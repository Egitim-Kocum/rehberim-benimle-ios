//
//  LoginContracts.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import RehberimBenimleUI
import RehberimBenimleCoreKit

@MainActor
protocol LoginViewControllerProtocol: BaseViewProtocol { }

@MainActor
protocol LoginPresenterProtocol: BasePresenterProtocol {
    var view: LoginViewControllerProtocol? { get set }
    func loginButtonTapped(email: String?, password: String?) async
    func forgotPasswordTapped()
    func signupTapped()
}

protocol LoginInteractorProtocol: Sendable {
    func login(email: String, password: String) async throws -> AuthResponse
}

@MainActor
protocol LoginRouterProtocol: AnyObject {
    func navigateToInfos(role: UserType)
    func navigateToHome()
    func navigateToForgotPassword()
    func navigateToSignup()
}
