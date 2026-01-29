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

    public enum Style: Equatable {
        case email
        case password, confirmPassword
        case normal(String)
    }

    // MARK: - Properties

    private let style: Style
    private var validationState: LoadingState = .idle {
        didSet { updateValidationAppearance() }
    }
    
    private let padding = UIEdgeInsets(
        top: DesignSystem.Spacing.lg,
        left: DesignSystem.Spacing.md,
        bottom: DesignSystem.Spacing.sm,
        right: DesignSystem.Spacing.xxl
    )
    
    private var placeholderText: String = ""
    private var isRequired: Bool = false

    
    // MARK: - UI Components

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = DesignSystem.Typography.body
        label.textColor = DesignSystem.Colors.secondaryText
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = DesignSystem.Colors.separator.cgColor
        return layer
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = DesignSystem.Typography.caption1
        label.textColor = DesignSystem.Colors.error
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
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

    public init(style: Style, isRequired: Bool = false) {
        self.style = style
        self.isRequired = isRequired
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        borderLayer.frame = bounds
        borderLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: DesignSystem.CornerRadius.sm).cgPath
        
        updateLabelState(animated: false)
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupTextField()
        setupStyle()
        setupTitleLabel()
        setupErrorLabel()
        setupConstraints()
        addObservers()
    }

    private func setupTextField() {
        delegate = self
        font = DesignSystem.Typography.body
        textColor = DesignSystem.Colors.primaryText
        tintColor = DesignSystem.Colors.primaryText
        backgroundColor = DesignSystem.Colors.inputBackground
        borderStyle = .none
        returnKeyType = .done
        
        placeholder = nil
        
        layer.addSublayer(borderLayer)
        layer.cornerRadius = DesignSystem.CornerRadius.sm
    }
    
    private func setupStyle() {
        switch style {
        case .email:
            placeholderText = "Email"
            keyboardType = .emailAddress
            autocapitalizationType = .none
            autocorrectionType = .no
            
        case .password:
            placeholderText = "Şifre"
            configureSecureField()
            
        case .confirmPassword:
            placeholderText = "Şifreyi Onayla"
            configureSecureField()
            
        case .normal(let text):
            placeholderText = text
        }
        
        updateTitleText(isEditing: false)
    }
    
    private func configureSecureField() {
        isSecureTextEntry = true
        autocapitalizationType = .none
        autocorrectionType = .no
        
        if ProcessInfo.processInfo.arguments.contains("--ui-testing") {
            textContentType = .oneTimeCode
        } else {
            textContentType = .password
        }
        
        setupEyeButton()
    }
    
    private func setupEyeButton() {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 30))
        eyeButton.frame = CGRect(x: 7, y: 0, width: 30, height: 30)
        container.addSubview(eyeButton)
        rightView = container
        rightViewMode = .always
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.isUserInteractionEnabled = false
    }
    
    private func setupErrorLabel() {
        addSubview(errorLabel)
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        snp.makeConstraints { make in
            make.height.equalTo(DesignSystem.ButtonSize.md)
        }
    }
    
    private func addObservers() {
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    // MARK: - Validation Appearance
        
    public func render(state: LoadingState) {
        validationState = state
    }
    
    private func updateValidationAppearance() {
        switch validationState {
        case .success:
            updateBorder(color: DesignSystem.Colors.success, width: 2)
            titleLabel.textColor = DesignSystem.Colors.success
            errorLabel.isHidden = true
            
        case .error(let message):
            updateBorder(color: DesignSystem.Colors.error, width: 2)
            titleLabel.textColor = DesignSystem.Colors.error
            errorLabel.text = message
            errorLabel.isHidden = false
            
        default:
            let color = isEditing ? DesignSystem.Colors.primaryButton : DesignSystem.Colors.separator
            let width: CGFloat = isEditing ? 2 : 1
            updateBorder(color: color, width: width)
            updateTitleColor()
            errorLabel.isHidden = true
        }
    }
    
    private func updateTitleColor() {
        guard case .idle = validationState else { return }
        
        if isEditing {
            titleLabel.textColor = DesignSystem.Colors.primaryButton
        } else {
            titleLabel.textColor = DesignSystem.Colors.secondaryText
        }
    }
    
    private func updateTitleText(isEditing: Bool) {
        guard isRequired else {
            titleLabel.text = placeholderText
            return
        }
        
        if isEditing {
            titleLabel.text = placeholderText
        } else {
            titleLabel.text = "\(placeholderText)*"
        }
    }
    
    private func updateBorder(color: UIColor, width: CGFloat) {
        borderLayer.strokeColor = color.cgColor
        borderLayer.lineWidth = width
    }
    
    // MARK: - Animation
    
    private func updateLabelState(animated: Bool) {
        let shouldFloat = isEditing || !(text?.isEmpty ?? true)
        
        let targetTransform: CGAffineTransform
        
        if shouldFloat {
            let translationY: CGFloat = -14
            let translationX: CGFloat = -2
            
            let scale: CGFloat = 0.75
            
            targetTransform = CGAffineTransform(translationX: translationX, y: translationY)
                .scaledBy(x: scale, y: scale)
        } else {
            targetTransform = .identity
        }
        
        let animationBlock = {
            self.titleLabel.transform = targetTransform
            self.updateTitleColor()
        }
        
        if animated {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: animationBlock)
        } else {
            animationBlock()
        }
    }
    
    // MARK: - Floating Label Animation
    
    @objc private func textDidChange() { }
    
    @objc private func editingDidBegin() {
        updateTitleText(isEditing: true)
        updateValidationAppearance()
        updateLabelState(animated: true)
    }
    
    @objc private func editingDidEnd() {
        updateTitleText(isEditing: false)
        updateValidationAppearance()
        updateLabelState(animated: true)
    }
    
    // MARK: - Actions
    
    @objc private func togglePasswordVisibility() {
        eyeButton.isSelected.toggle()
        
        let currentText = text
        let selectedRange = selectedTextRange
        
        isSecureTextEntry.toggle()
        
        text = currentText
        
        if let selectedRange = selectedRange {
            self.selectedTextRange = selectedRange
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
        .zero
    }
}

// MARK: - UITextFieldDelegate

extension AppTextField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
}
