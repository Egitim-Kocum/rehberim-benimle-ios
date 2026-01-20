//
//  AppDropDown.swift
//  RehberimBenimleUI
//
//  Created by Okan Orkun on 19.01.2026.
//

import UIKit
import RehberimBenimleCoreKit
import SnapKit

public protocol AppDropDownItem {
    var itemTitle: String { get }
    var isValid: Bool { get }
}

public final class AppDropDown<T: AppDropDownItem & CaseIterable & Equatable>: UIControl, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Public Variables
    public var onItemSelected: ((T) -> Void)?
    public private(set) var selectedItem: T?
    
    // MARK: - Private Variables
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let chevronImageView = UIImageView()
    private let items: [T]
    
    private lazy var dummyField: UITextField = {
        let field = UITextField(frame: .zero)
        field.inputView = pickerView
        field.inputAccessoryView = toolbar
        return field
    }()
    
    // MARK: - UI Components
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Tamam", style: .done, target: self, action: #selector(doneTapped))
        toolbar.setItems([flex, done], animated: false)
        return toolbar
    }()
    
    // MARK: - Init
    public init(
        initialValue: T? = nil
    ) {
        self.items = Array(T.allCases)
        self.selectedItem = initialValue
        super.init(frame: .zero)
        
        setupUI()
        configureInitialState()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    deinit {
        dummyField.removeFromSuperview()
    }
    
    // MARK: - Public API
    public var text: String? {
        get { titleLabel.text }
        set {
            titleLabel.text = newValue
            
            if let selectedItem, !selectedItem.isValid {
                titleLabel.textColor = .secondaryLabel
            } else {
                titleLabel.textColor = .label
            }

        }
    }
    
    public func setSelectedItem(_ item: T) {
        selectedItem = item
        text = item.itemTitle
        
        if let index = items.firstIndex(where: { $0.itemTitle == item.itemTitle }) {
            pickerView.selectRow(index, inComponent: 0, animated: false)
        }
        
        accessibilityValue = item.itemTitle
    }
    
    // MARK: - Setup
    private func setupUI() {
        addSubview(dummyField)
        
        isAccessibilityElement = true
        accessibilityTraits = .button
        
        layer.cornerRadius = DesignSystem.CornerRadius.md
        layer.borderColor = DesignSystem.Colors.primaryText.cgColor
        backgroundColor = DesignSystem.Colors.inputBackground
        
        titleLabel.textColor = DesignSystem.Colors.primaryText
        titleLabel.font = DesignSystem.Typography.body
        titleLabel.numberOfLines = 1
        
        chevronImageView.image = UIImage(systemName: "chevron.up.chevron.down")
        chevronImageView.tintColor = DesignSystem.Colors.primaryText
        chevronImageView.contentMode = .scaleAspectFit
        
        containerView.isUserInteractionEnabled = false
        
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(chevronImageView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.trailing.equalTo(chevronImageView.snp.leading).offset(-8)
        }
        
        chevronImageView.snp.makeConstraints {
            $0.trailing.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }
        
        snp.makeConstraints {
            $0.height.equalTo(56)
        }
    }

    private func configureInitialState() {
        if let selectedItem,
           let index = items.firstIndex(of: selectedItem) {
            
            pickerView.selectRow(index, inComponent: 0, animated: false)
            text = selectedItem.itemTitle
            return
        }

        guard let firstItem = items.first else { return }

        selectedItem = firstItem
        pickerView.selectRow(0, inComponent: 0, animated: false)
        text = firstItem.itemTitle
    }

    
    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
    }
    
    // MARK: - Actions
    @objc private func doneTapped() {
        dummyField.resignFirstResponder()
    }
    
    @objc private func didTap() {
        if let selectedItem,
           let index = items.firstIndex(where: { $0.itemTitle == selectedItem.itemTitle }) {
            pickerView.selectRow(index, inComponent: 0, animated: false)
        } else {
            pickerView.selectRow(0, inComponent: 0, animated: false)
        }
        dummyField.becomeFirstResponder()
    }
    
    // MARK: - UIPickerViewDataSource
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        items.count
    }
    
    // MARK: - UIPickerViewDelegate
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row].itemTitle
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = items[row]
        selectedItem = item
        text = item.itemTitle
        accessibilityValue = item.itemTitle
        onItemSelected?(item)
        sendActions(for: .valueChanged)
    }
    
}
