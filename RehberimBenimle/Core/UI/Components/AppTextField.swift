//
//  AppTextField.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import UIKit

final class AppTextField: UITextField {

    enum Style {
        case email
        case password
        case normal
    }

    private let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    // MARK: - Init

    init(style: Style) {
        super.init(frame: .zero)
        configureBase()
        configureStyle(style)
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    private func configureBase() {
        font = .preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true

        backgroundColor = UIColor.inputBackground
        textColor = UIColor.primaryText
        tintColor = UIColor.secondaryText

        layer.cornerRadius = 12
        layer.masksToBounds = true
        borderStyle = .none
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

    private func applyConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }

    // MARK: - Padding Overrides

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}
