//
//  AppTextField.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import UIKit
import RehberimBenimleCoreKit

public final class AppTextField: UITextField, UITextFieldDelegate {

    // MARK: - Types

    public enum Style: Equatable {
        case email
        case password, confirmPassword
        case normal(String)
    }

    // MARK: - Properties

    private let padding = UIEdgeInsets(
        top: DesignSystem.Spacing.sm,
        left: DesignSystem.Spacing.md,
        bottom: DesignSystem.Spacing.sm,
        right: DesignSystem.Spacing.xxl
    )
    
    private lazy var eyeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.tintColor = DesignSystem.Colors.secondaryText
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }()

    // MARK: - Init

    public init(style: Style) {
        super.init(frame: .zero)
        configureBase()
        configureDelegate()
        configureStyle(style)
        applyLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    private func configureBase() {
        font = DesignSystem.Typography.body
        textColor = DesignSystem.Colors.primaryText
        tintColor = DesignSystem.Colors.primaryText
        backgroundColor = DesignSystem.Colors.inputBackground

        layer.cornerRadius = DesignSystem.CornerRadius.md
        layer.masksToBounds = true
        borderStyle = .none

        adjustsFontForContentSizeCategory = true
    }
    
    private func configureDelegate() {
        delegate = self
        returnKeyType = .done
    }

    private func configureStyle(_ style: Style) {
        switch style {
        case .email:
            placeholder = "Email"
            keyboardType = .emailAddress
            autocapitalizationType = .none
            autocorrectionType = .no

        case .password, .confirmPassword:
            placeholder = (style == .password) ? "Şifre" : "Şifreyi Onayla"
            isSecureTextEntry = true
            autocapitalizationType = .none
            autocorrectionType = .no
            setupRightView()

        case .normal(let placeholderText):
            placeholder = placeholderText
            break
        }
    }
    
    private func setupRightView() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 30))
        eyeButton.center = CGPoint(x: 22, y: 15)
        container.addSubview(eyeButton)
        
        rightView = container
        rightViewMode = .always
    }

    private func applyLayout() {
        snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }
    
    // MARK: - Actions
    @objc private func togglePasswordVisibility() {
        eyeButton.isSelected.toggle()
        isSecureTextEntry.toggle()
        
        if let existingText = text {
            text = nil
            text = existingText
        }
    }

    // MARK: - Padding
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}
