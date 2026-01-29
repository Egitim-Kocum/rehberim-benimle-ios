//
//  LoginPresenter.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import Foundation
import RehberimBenimleUI

@MainActor
final class LoginPresenter {

    weak var view: LoginViewControllerProtocol?
    private let interactor: LoginInteractorProtocol
    private let router: LoginRouterProtocol
    private let validator: LoginValidatorProtocol

    init(
        interactor: LoginInteractorProtocol,
        router: LoginRouterProtocol,
        validator: LoginValidatorProtocol
    ) {
        self.interactor = interactor
        self.router = router
        self.validator = validator
    }
}

// MARK: - LoginPresenterProtocol
extension LoginPresenter: LoginPresenterProtocol {

    func viewDidLoad() { }

    func loginButtonTapped(email: String?, password: String?) async {
        do {
            let validated = try validator.validate(email: email, password: password)
            await performLogin(email: validated.email, password: validated.password)
        } catch {
            view?.render(state: .error(error.localizedDescription))
        }
    }

    func forgotPasswordTapped() {
        router.navigateToForgotPassword()
    }
    
    func signupTapped() {
        router.navigateToSignup()
    }
}

// MARK: - Private Helpers
private extension LoginPresenter {
    func performLogin(email: String, password: String) async {
        view?.render(state: .loading)

        do {
            let response = try await interactor.login(email: email, password: password)
            view?.render(state: .success)
                        
            let uiRole: UserType
            switch response.role {
            case "student": uiRole = .student
            case "instructor": uiRole = .instructor
            default: uiRole = .student
            }
            
            if response.isProfileCompleted {
                router.navigateToHome()
            } else {
                router.navigateToInfos(role: uiRole)
            }
        } catch {
            view?.render(state: .error(error.localizedDescription))
        }
    }
}
