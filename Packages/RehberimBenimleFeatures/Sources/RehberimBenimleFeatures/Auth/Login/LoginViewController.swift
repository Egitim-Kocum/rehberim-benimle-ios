//
//  LoginViewController.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import RehberimBenimleUI

final class LoginViewController: BaseViewController {

    private let presenter: LoginPresenterProtocol

    init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - UI Components

    private lazy var emailTextField: UITextField = {
        let tf = AppTextField(style: .email)
        tf.accessibilityIdentifier = LoginAccessibilityID.emailTextField
        return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = AppTextField(style: .password)
        tf.accessibilityIdentifier = LoginAccessibilityID.passwordTextField
        return tf
    }()

    private lazy var forgotPasswordButton = AppButton(
        title: "Şifremi Unuttum",
        style: .text,
        isUnderlined: true,
        accessibilityIdentifier: LoginAccessibilityID.forgotPasswordButton
    )

    private lazy var loginButton = AppButton(
        title: "Giriş Yap",
        style: .primary,
        accessibilityIdentifier: LoginAccessibilityID.loginButton
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
        
        title = "Giriş Yap"
        
        view.accessibilityIdentifier = LoginAccessibilityID.viewId

        view.addSubviews(
            emailTextField,
            passwordTextField,
            forgotPasswordButton,
            loginButton
        )

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        forgotPasswordButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }

        loginButton.snp.makeConstraints {
            $0.top.equalTo(forgotPasswordButton.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(56)
        }
    }

    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(forgotTapped), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func loginTapped() {
        Task {
            await presenter.loginButtonTapped(
                email: emailTextField.text,
                password: passwordTextField.text
            )
        }
    }

    @objc private func forgotTapped() {
        presenter.forgotPasswordTapped()
    }
}

extension LoginViewController: LoginViewControllerProtocol {
    
}

// MARK: - Preview
#if DEBUG
import SwiftUI

@MainActor
private class MockLoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewControllerProtocol?
    
    func viewDidLoad() {
        print("Preview: viewDidLoad")
    }
    
    func loginButtonTapped(email: String?, password: String?) {
        print("Preview: login tapped with email: \(email ?? "nil")")
    }
    
    func forgotPasswordTapped() {
        print("Preview: forgot password tapped")
    }
}

#Preview("Login Screen") {
    LoginViewController(presenter: MockLoginPresenter())
}
#endif
