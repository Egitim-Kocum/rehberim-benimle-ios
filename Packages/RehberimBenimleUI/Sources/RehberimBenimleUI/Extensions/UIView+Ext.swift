//
//  UIView+Ext.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import UIKit

public extension UIView {
    func addSubviews(_ view: UIView...) {
        view.forEach { self.addSubview($0) }
    }
    
    @discardableResult
    func styled(
        backgroundColor: UIColor? = nil,
        cornerRadius: CGFloat? = nil,
        borderWidth: CGFloat? = nil,
        borderColor: UIColor? = nil,
        shadow: DesignSystem.Elevation.Level? = nil
    ) -> Self {
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = shadow == nil // Don't clip if shadow
        }
        
        if let borderWidth = borderWidth {
            layer.borderWidth = borderWidth
        }
        
        if let borderColor = borderColor {
            layer.borderColor = borderColor.cgColor
        }
        
        if let shadow = shadow {
            layer.masksToBounds = false
            DesignSystem.Elevation.apply(shadow, to: layer)
        }
        
        return self
    }
}
