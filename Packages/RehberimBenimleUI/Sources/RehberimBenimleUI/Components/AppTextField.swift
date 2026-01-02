//
//  AppTextField.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import UIKit
import RehberimBenimleCoreKit

public final class AppTextField: UITextField {

    // MARK: - Types

    public enum Style {
        case email
        case password
        case normal
    }

    // MARK: - Properties

    private let padding = UIEdgeInsets(
        top: DesignSystem.Spacing.sm,
        left: DesignSystem.Spacing.md,
        bottom: DesignSystem.Spacing.sm,
        right: DesignSystem.Spacing.md
    )

    // MARK: - Init

    public init(style: Style) {
        super.init(frame: .zero)
        configureBase()
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

    private func configureStyle(_ style: Style) {
        switch style {
        case .email:
            placeholder = "Email"
            keyboardType = .emailAddress
            autocapitalizationType = .none
            autocorrectionType = .no

        case .password:
            placeholder = "Password"
            isSecureTextEntry = true
            autocapitalizationType = .none
            autocorrectionType = .no

        case .normal:
            break
        }
    }

    private func applyLayout() {
        snp.makeConstraints {
            $0.height.equalTo(56)
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
