//
//  UIView+Ext.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ view: UIView...) {
        view.forEach { self.addSubview($0) }
    }
}
