//
//  LoginViewController.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import UIKit
import SnapKit

final class LoginViewController: BaseViewController {

    private let presenter: LoginPresenterProtocol

    init(presenter: LoginPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    // MARK: - UI Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Student Login"
        label.font = .preferredFont(forTextStyle: .title2)
        label.textColor = UIColor.primaryText
        label.textAlignment = .center
        label.accessibilityIdentifier = LoginAccessibilityID.titleLabel
        return label
    }()

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

    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        let title = "Forgot Password?"
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: UIColor.secondaryText,
            .font: UIFont.preferredFont(forTextStyle: .body)
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.contentHorizontalAlignment = .left
        button.accessibilityIdentifier = LoginAccessibilityID.forgotPasswordButton
        return button
    }()


    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor.primaryButton
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.accessibilityIdentifier = LoginAccessibilityID.loginButton
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupUI()
        setupActions()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = UIColor.background

        view.addSubviews(
            titleLabel,
            emailTextField,
            passwordTextField,
            forgotPasswordButton,
            loginButton
        )

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            $0.centerX.equalToSuperview()
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
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
