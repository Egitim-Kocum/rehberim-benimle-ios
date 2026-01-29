//
//  SignupContracts.swift
//  RehberimBenimleFeatures
//
//  Created by Okan Orkun on 19.01.2026.
//

import RehberimBenimleUI

@MainActor
protocol SignupViewControllerProtocol: BaseViewProtocol {
    func renderFullName(state: LoadingState)
    func renderEmail(state: LoadingState)
    func renderPassword(state: LoadingState)
    func renderConfirmPassword(state: LoadingState)
}

@MainActor
protocol SignupPresenterProtocol: BasePresenterProtocol {
    var view: SignupViewControllerProtocol? { get set }
    
    func signupButtonTapped(role: UserType?, fullName: String?, email: String?, password: String?, confirmPassword: String?) async
    func alreadyHaveAccountTapped()
    
    func validateFullName(_ text: String?)
    func validateEmail(_ text: String?)
    func validatePassword(_ text: String?)
    func validateConfirmPassword(password: String?, confirmPassword: String?)
}

protocol SignupInteractorProtocol: Sendable {
    func signup(role: String, fullName: String, email: String, password: String) async throws
}

@MainActor
protocol SignupRouterProtocol: AnyObject {
    func navigateToLogin()
}
