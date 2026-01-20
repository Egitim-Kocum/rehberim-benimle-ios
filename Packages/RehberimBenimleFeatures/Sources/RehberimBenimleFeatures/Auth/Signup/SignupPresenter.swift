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
}

// MARK: - Private Helpers
private extension SignupPresenter {
    func performSignup(role: String, fullName: String, email: String, password: String) async {
        view?.render(state: .loading)
        
        do {
            try await interactor.signup(role: role, fullName: fullName, email: email, password: password)
            view?.render(state: .success)
            router.navigateToInfos()
        } catch {
            view?.render(state: .error(error.localizedDescription))
        }
    }
}
