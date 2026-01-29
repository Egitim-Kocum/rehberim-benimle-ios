//
//  SignupViewController.swift
//  RehberimBenimleFeatures
//
//  Created by Okan Orkun on 19.01.2026.
//

import RehberimBenimleUI
import Combine

final class SignupViewController: BaseViewController {
    
    private let presenter: SignupPresenterProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(presenter: SignupPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - UI Components
    
    private lazy var userRoleSegmentedControl = {
        let control = AppSegmentedControl<UserType>(items: UserType.allCases, selected: .student)
        control.accessibilityIdentifier = SignupAccessibilityID.userRoleSegmented
        return control
    }()
    
    private lazy var fullNameTextField: AppTextField = {
        let tf = AppTextField(style: .normal("İsim"), isRequired: true)
        tf.accessibilityIdentifier = SignupAccessibilityID.fullNameTextField
        return tf
    }()
    
    private lazy var emailTextField: AppTextField = {
        let tf = AppTextField(style: .email, isRequired: true)
        tf.accessibilityIdentifier = SignupAccessibilityID.emailTextField
        return tf
    }()
    
    private lazy var passwordTextField: AppTextField = {
        let tf = AppTextField(style: .password, isRequired: true)
        tf.accessibilityIdentifier = SignupAccessibilityID.passwordTextField
        return tf
    }()
    
    private lazy var confirmPasswordTextField: AppTextField = {
        let tf = AppTextField(style: .confirmPassword, isRequired: true)
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
        setupValidationObservers()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = DesignSystem.Colors.background
        
        title = "Kayıt Ol"
        
        view.accessibilityIdentifier = SignupAccessibilityID.viewId

        view.addSubviews(
            userRoleSegmentedControl,
            fullNameTextField,
            emailTextField,
            passwordTextField,
            confirmPasswordTextField,
            signUpButton,
            alreadyHaveAccountButton,
            
        )
        
        userRoleSegmentedControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(DesignSystem.Spacing.lg)
            $0.leading.trailing.equalToSuperview().inset(DesignSystem.Spacing.md)
        }

        fullNameTextField.snp.makeConstraints {
            $0.top.equalTo(userRoleSegmentedControl.snp.bottom).offset(DesignSystem.Spacing.lg)
            $0.leading.trailing.equalToSuperview().inset(DesignSystem.Spacing.md)
        }

        emailTextField.snp.makeConstraints {
            $0.top.equalTo(fullNameTextField.snp.bottom).offset(DesignSystem.Spacing.lg)
            $0.leading.trailing.equalToSuperview().inset(DesignSystem.Spacing.md)
        }

        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(DesignSystem.Spacing.lg)
            $0.leading.trailing.equalToSuperview().inset(DesignSystem.Spacing.md)
        }
        
        confirmPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(DesignSystem.Spacing.lg)
            $0.leading.trailing.equalToSuperview().inset(DesignSystem.Spacing.md)
        }

        signUpButton.snp.makeConstraints {
            $0.top.equalTo(confirmPasswordTextField.snp.bottom).offset(DesignSystem.Spacing.lg)
            $0.leading.trailing.equalToSuperview().inset(DesignSystem.Spacing.md)
            $0.height.equalTo(56)
        }
        
        alreadyHaveAccountButton.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(DesignSystem.Spacing.sm)
            $0.centerX.equalToSuperview()
        }
    }

    private func setupActions() {
        signUpButton.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        alreadyHaveAccountButton.addTarget(self, action: #selector(alreadyHaveAccountTapped), for: .touchUpInside)
    }
    
    private func setupValidationObservers() {
        // Full Name
        fullNameTextField.textPublisher
            .dropFirst()
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.presenter.validateFullName(text)
            }
            .store(in: &cancellables)
        
        // Email
        emailTextField.textPublisher
            .dropFirst()
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.presenter.validateEmail(text)
            }
            .store(in: &cancellables)
        
        // Password
        passwordTextField.textPublisher
            .dropFirst()
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.presenter.validatePassword(text)
            }
            .store(in: &cancellables)
        
        // Confirm Password
        Publishers.CombineLatest(
            passwordTextField.textPublisher,
            confirmPasswordTextField.textPublisher
        )
        .dropFirst()
        .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
        .sink { [weak self] password, confirmPassword in
            self?.presenter.validateConfirmPassword(password: password, confirmPassword: confirmPassword)
        }
        .store(in: &cancellables)
    }

    // MARK: - Actions
    
    @objc private func signupTapped() {
        Task {
            await presenter.signupButtonTapped(
                role: userRoleSegmentedControl.selectedItem,
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

extension SignupViewController: SignupViewControllerProtocol {
    func renderFullName(state: LoadingState) {
        fullNameTextField.render(state: state)
    }
    
    func renderEmail(state: LoadingState) {
        emailTextField.render(state: state)
    }
    
    func renderPassword(state: LoadingState) {
        passwordTextField.render(state: state)
    }
    
    func renderConfirmPassword(state: LoadingState) {
        confirmPasswordTextField.render(state: state)
    }
}

// MARK: - Preview
#if DEBUG
import SwiftUI

@MainActor
private class MockSignupPresenter: SignupPresenterProtocol {
    func roleChanged(_ role: RehberimBenimleUI.UserType) {
        
    }
    
    
    func validateFullName(_ fullName: String?) {
        
    }
    
    func validateEmail(_ email: String?) {
        
    }
    
    func validatePassword(_ password: String?) {
        
    }
    
    func validateConfirmPassword(password confirmPassword: String?, confirmPassword password: String?) {
        
    }
    
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
