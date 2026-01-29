//
//  SignupPresenter.swift
//  RehberimBenimleFeatures
//
//  Created by Okan Orkun on 19.01.2026.
//

import RehberimBenimleUI

@MainActor
final class SignupPresenter {
    
    weak var view: SignupViewControllerProtocol?
    private let interactor: SignupInteractorProtocol
    private let router: SignupRouterProtocol
    private let validator: SignupValidatorProtocol
    
    init(
        interactor: SignupInteractorProtocol,
        router: SignupRouterProtocol,
        validator: SignupValidatorProtocol
    ) {
        self.interactor = interactor
        self.router = router
        self.validator = validator
    }
}

// MARK: - SignupPresenterProtocol
extension SignupPresenter: SignupPresenterProtocol {
    
    func viewDidLoad() { }
    
    func signupButtonTapped(role: UserType?, fullName: String?, email: String?, password: String?, confirmPassword: String?) async {
        do {
            let validated = try validator.validate(role: role, fullName: fullName, email: email, password: password, confirmPassword: confirmPassword)
            await performSignup(role: validated.role, fullName: validated.fullName, email: validated.email, password: validated.password)
        } catch {
            view?.render(state: .error(error.localizedDescription))
        }
    }
    
    func alreadyHaveAccountTapped() {
        router.navigateToLogin()
    }
    
    func validateFullName(_ text: String?) {
        guard let text, !text.isEmpty else {
            view?.renderFullName(state: .idle)
            return
        }
        
        do {
            try text.validateNotEmpty(fieldName: "İsim")
            view?.renderFullName(state: .success)
        } catch {
            view?.renderFullName(state: .error(error.localizedDescription))
        }
    }
    
    func validateEmail(_ text: String?) {
        guard let text, !text.isEmpty else {
            view?.renderEmail(state: .idle)
            return
        }
        
        do {
            try text.validateEmail()
            view?.renderEmail(state: .success)
        } catch {
            view?.renderEmail(state: .error(error.localizedDescription))
        }
    }
    
    func validatePassword(_ text: String?) {
        guard let text, !text.isEmpty else {
            view?.renderPassword(state: .idle)
            return
        }
        
        do {
            try text.validatePassword()
            view?.renderPassword(state: .success)
        } catch {
            view?.renderPassword(state: .error(error.localizedDescription))
        }
    }
    
    func validateConfirmPassword(password: String?, confirmPassword: String?) {
        guard let confirmPassword, !confirmPassword.isEmpty else {
            view?.renderConfirmPassword(state: .idle)
            return
        }
        
        guard let password, !password.isEmpty else {
            view?.renderConfirmPassword(state: .error("Önce şifre girin"))
            return
        }
        
        do {
            try confirmPassword.validateConfirmPassword(matches: password)
            view?.renderConfirmPassword(state: .success)
        } catch {
            view?.renderConfirmPassword(state: .error(error.localizedDescription))
        }
    }
}

// MARK: - Private Helpers
private extension SignupPresenter {
    func performSignup(role: String, fullName: String, email: String, password: String) async {
        view?.render(state: .loading)
        
        do {
            try await interactor.signup(role: role, fullName: fullName, email: email, password: password)
            view?.render(state: .success)
            router.navigateToLogin()
        } catch {
            view?.render(state: .error(error.localizedDescription))
        }
    }
}
