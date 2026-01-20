//
//  AppButton.swift
//  RehberimBenimleUI
//
//  Created by Okan Orkun on 19.01.2026.
//

import UIKit
import RehberimBenimleCoreKit

public final class AppButton: UIButton {

    // MARK: - Types

    public enum Style {
        case primary
        case text
    }

    // MARK: - Init

    public init(
        title: String,
        style: Style,
        isUnderlined: Bool = false,
        accessibilityIdentifier: String? = nil
    ) {
        super.init(frame: .zero)
        configureBase()
        configureStyle(
            title: title,
            style: style,
            isUnderlined: isUnderlined
        )
        self.accessibilityIdentifier = accessibilityIdentifier
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    private func configureBase() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureStyle(
        title: String,
        style: Style,
        isUnderlined: Bool
    ) {
        switch style {
        case .primary:
            setTitle(title, for: .normal)
            backgroundColor = DesignSystem.Colors.primaryButton
            setTitleColor(.white, for: .normal)
            titleLabel?.font = DesignSystem.Typography.preferredFont(for: .headline)
            layer.cornerRadius = 10

        case .text:
            backgroundColor = .clear
            contentHorizontalAlignment = .left
            applyTextStyle(
                title: title,
                isUnderlined: isUnderlined
            )
        }
    }

    private func applyTextStyle(
        title: String,
        isUnderlined: Bool
    ) {
        var attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: DesignSystem.Colors.secondaryText,
            .font: DesignSystem.Typography.preferredFont(for: .body)
        ]

        if isUnderlined {
            attributes[.underlineStyle] = NSUnderlineStyle.single.rawValue
        }

        let attributedTitle = NSAttributedString(
            string: title,
            attributes: attributes
        )
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
