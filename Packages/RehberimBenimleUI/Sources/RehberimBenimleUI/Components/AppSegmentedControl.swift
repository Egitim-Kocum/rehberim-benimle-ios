//
//  AppSegmentedControl.swift
//  RehberimBenimleUI
//
//  Created by Okan Orkun on 25.01.2026.
//

import UIKit
import SnapKit
import RehberimBenimleCoreKit

public protocol AppSegmentedItem: Equatable {
    var title: String { get }
}

public final class AppSegmentedControl<Item: AppSegmentedItem>: UIControl {

    // MARK: - Public API

    public private(set) var selectedItem: Item {
        didSet {
            updateSelection()
            onRoleChanged?(selectedItem)
        }
    }

    public var onRoleChanged: ((Item) -> Void)?

    // MARK: - Private

    private let items: [Item]
    private var buttons: [UIButton] = []
    private let stackView = UIStackView()

    // MARK: - Init

    public init(items: [Item], selected: Item) {
        self.items = items
        self.selectedItem = selected
        super.init(frame: .zero)
        setupUI()
        updateSelection()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender) else { return }
        let item = items[index]
        guard item != selectedItem else { return }
        selectedItem = item
    }
}

private extension AppSegmentedControl {

    func setupUI() {
        layer.cornerRadius = DesignSystem.CornerRadius.md
        backgroundColor = DesignSystem.Colors.inputBackground

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = DesignSystem.Spacing.xxs

        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(DesignSystem.Spacing.xxs)
            make.bottom.equalToSuperview().inset(DesignSystem.Spacing.xxs)
            make.leading.equalToSuperview().offset(DesignSystem.Spacing.xxs)
            make.trailing.equalToSuperview().inset(DesignSystem.Spacing.xxs)
        }

        createButtons()
    }
    
    func createButtons() {
        items.forEach { item in
            let button = UIButton(type: .system)
            button.setTitle(item.title, for: .normal)
            button.titleLabel?.font = DesignSystem.Typography.body
            button.layer.cornerRadius = DesignSystem.Spacing.xs
            button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
            buttons.append(button)
            stackView.addArrangedSubview(button)
        }
    }
    
    func updateSelection() {
        for (index, item) in items.enumerated() {
            let button = buttons[index]
            let isSelected = item == selectedItem

            UIView.animate(withDuration: DesignSystem.Animation.durationNormal) {
                button.backgroundColor = isSelected
                ? DesignSystem.Colors.primaryButton
                : DesignSystem.Colors.inputBackground

                button.setTitleColor(
                    isSelected
                        ? .white
                        : DesignSystem.Colors.secondaryText,
                    for: .normal
                )
            }
        }
    }
}
