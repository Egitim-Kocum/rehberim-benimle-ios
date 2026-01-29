//
//  UIColor+Ext.swift
//  RehberimBenimleUI
//
//  Created by Okan Orkun on 31.12.2025.
//

import UIKit

public extension UIColor {
    
    /// Hex string'den UIColor oluştur
    /// - Parameters:
    ///   - hex: "#FF5733" veya "FF5733" formatında hex string
    ///   - alpha: Opacity değeri (0.0 - 1.0)
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// RGB değerlerinden UIColor oluştur (0-255 arası)
    /// - Parameters:
    ///   - r: Red (0-255)
    ///   - g: Green (0-255)
    ///   - b: Blue (0-255)
    ///   - a: Alpha (0.0-1.0)
    convenience init(r: Int, g: Int, b: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: a
        )
    }
}
