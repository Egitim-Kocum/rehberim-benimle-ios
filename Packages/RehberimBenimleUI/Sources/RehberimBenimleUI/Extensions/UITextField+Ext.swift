//
//  UITextField+Ext.swift
//  RehberimBenimleUI
//
//  Created by Okan Orkun on 24.01.2026.
//

import Combine
import UIKit

public extension UITextField {
    var textPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map { ($0.object as? UITextField)?.text }
            .eraseToAnyPublisher()
    }
}
