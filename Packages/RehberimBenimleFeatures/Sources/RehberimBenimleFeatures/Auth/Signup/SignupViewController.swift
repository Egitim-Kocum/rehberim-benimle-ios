//
//  SignupViewController.swift
//  RehberimBenimleFeatures
//
//  Created by Okan Orkun on 19.01.2026.
//

import RehberimBenimleUI

final class SignupViewController: BaseViewController {
    
    private let presenter: SignupPresenterProtocol
    
    init(presenter: SignupPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - UI Components
    
    private lazy var userDropdown: AppDropDown<UserType> = {
        let dd = AppDropDown<UserType>()
        dd.accessibilityIdentifier = SignupAccessibilityID.userDropDown
        return dd
    }()
    
    private lazy var fullNameTextField: UITextField = {
        let tf = AppTextField(style: .normal("İsim"))
        tf.accessibilityIdentifier = SignupAccessibilityID.fullNameTextField
        return tf
    }()
    
    private lazy var emailTextField: UITextField = {
        let tf = AppTextField(style: .email)
        tf.accessibilityIdentifier = SignupAccessibilityID.emailTextField
        return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = AppTextField(style: .password)
        tf.accessibilityIdentifier = SignupAccessibilityID.passwordTextField
        return tf
    }()
    
    private lazy var confirmPasswordTextField: UITextField = {
        let tf = AppTextField(style: .confirmPassword)
        tf.accessibilityIdentifier = SignupAccessibilityID.confirmPasswordTextField
        return tf
    }()
    
    private lazy var signUpButton = AppButton(
        title: "Kayıt Ol",
        style: .primary,
        accessibilityIdentifier: SignupAccessibilityID.signUpButton
    )

    private lazy var alreadyHaveAccountButton = AppButton(
        title: "Zaten bir hesabın var mı? Giriş yap",
        style: .text,
        isUnderlined: true,
        accessibilityIdentifier: SignupAccessibilityID.alreadyHaveAccountButton
    )

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupUI()
        setupActions()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = DesignSystem.Colors.background
        
        title = "Kayıt Ol"
        
        view.accessibilityIdentifier = SignupAccessibilityID.viewId

        view.addSubviews(
            userDropdown,
            fullNameTextField,
            emailTextField,
            passwordTextField,
            confirmPasswordTextField,
            signUpButton,
            alreadyHaveAccountButton,
            
        )
        
        userDropdown.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        fullNameTextField.snp.makeConstraints {
            $0.top.equalTo(userDropdown.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(fullNameTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        confirmPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        signUpButton.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(56)
        }
        
        alreadyHaveAccountButton.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }

    private func setupActions() {
        signUpButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        alreadyHaveAccountButton.addTarget(self, action: #selector(alreadyHaveAccountTapped), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func signupTapped() {
        Task {
            await presenter.signupButtonTapped(
                role: userDropdown.selectedItem,
                fullName: fullNameTextField.text,
                email: emailTextField.text,
                password: passwordTextField.text,
                confirmPassword: confirmPasswordTextField.text
            )
        }
    }

    @objc private func alreadyHaveAccountTapped() {
        presenter.alreadyHaveAccountTapped()
    }
}

extension SignupViewController: SignupViewControllerProtocol { }

// MARK: - Preview
#if DEBUG
import SwiftUI

@MainActor
private class MockSignupPresenter: SignupPresenterProtocol {
    weak var view: SignupViewControllerProtocol?
    
    func viewDidLoad() {
        print("Preview: viewDidLoad")
    }
    
    func signupButtonTapped(role: UserType?, fullName: String?, email: String?, password: String?, confirmPassword: String?) async {
        print("Preview: signup tapped with email: \(email ?? "nil")")
    }
    
    func alreadyHaveAccountTapped() {
        print("Preview: already have account tapped")

    }
}

#Preview("Login Screen") {
    SignupViewController(presenter: MockSignupPresenter())
}
#endif
