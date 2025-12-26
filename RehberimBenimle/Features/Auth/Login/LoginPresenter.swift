//
//  LoginPresenter.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import Foundation

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
}

// MARK: - Private Helpers
private extension LoginPresenter {
    func performLogin(email: String, password: String) async {
        view?.render(state: .loading)

        do {
            try await interactor.login(email: email, password: password)
            view?.render(state: .success)
            router.navigateToHome()
        } catch {
            view?.render(state: .error(error.localizedDescription))
        }
    }
}
