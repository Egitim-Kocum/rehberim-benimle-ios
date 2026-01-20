//
//  SignupContracts.swift
//  RehberimBenimleFeatures
//
//  Created by Okan Orkun on 19.01.2026.
//

import RehberimBenimleUI

@MainActor
protocol SignupViewControllerProtocol: BaseViewProtocol { }

@MainActor
protocol SignupPresenterProtocol: BasePresenterProtocol {
    var view: SignupViewControllerProtocol? { get set }
    
    func signupButtonTapped(role: UserType?, fullName: String?, email: String?, password: String?, confirmPassword: String?) async
    func alreadyHaveAccountTapped()
}

protocol SignupInteractorProtocol: Sendable {
    func signup(role: String, fullName: String, email: String, password: String) async throws
}

@MainActor
protocol SignupRouterProtocol: AnyObject {
    func navigateToInfos()
    func navigateToLogin()
}
