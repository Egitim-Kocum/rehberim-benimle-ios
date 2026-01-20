//
//  LoginContracts.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import RehberimBenimleUI

@MainActor
protocol LoginViewControllerProtocol: BaseViewProtocol { }

@MainActor
protocol LoginPresenterProtocol: BasePresenterProtocol {
    var view: LoginViewControllerProtocol? { get set }
    func loginButtonTapped(email: String?, password: String?) async
    func forgotPasswordTapped()
}

protocol LoginInteractorProtocol: Sendable {
    func login(email: String, password: String) async throws
}

@MainActor
protocol LoginRouterProtocol: AnyObject {
    func navigateToHome()
    func navigateToForgotPassword()
}
