//
//  DesignSystem.swift
//  RehberimBenimleUI
//
//  Created by Okan Orkun on 31.12.2025.
//

import UIKit

// MARK: - Design System

public enum DesignSystem {
    
    // MARK: - Colors
    
    public enum Colors {
        
        // MARK: Background Colors
        
        public static let background = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#1C1C1E")
                : UIColor.systemBackground
        }
        
        public static let inputBackground = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#2C2C2E")
                : UIColor(hex: "#F2F2F7")
        }
        
        // MARK: Text Colors
        
        public static let primaryText = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? .white
                : UIColor(hex: "#1C1C1E")
        }
        
        public static let secondaryText = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#8E8E93")
                : UIColor(hex: "#636366")
        }
        
        // MARK: Button Colors
        
        public static let primaryButton = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#0A84FF")
                : UIColor(hex: "#007AFF")
        }
        
        public static let secondaryButton = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#48484A")
                : UIColor(hex: "#EBEBF0")
        }
        
        // MARK: Status Colors
        
        public static let success = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#30D158")
                : UIColor(hex: "#34C759")
        }
        
        public static let error = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#FF453A")
                : UIColor(hex: "#FF3B30")
        }
        
        public static let warning = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#FFD60A")
                : UIColor(hex: "#FF9500")
        }
        
        // MARK: Separator
        
        public static let separator = UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(hex: "#38383A")
                : UIColor(hex: "#C6C6C8")
        }
    }
    
    // MARK: - Typography
    
    public enum Typography {
        
        // MARK: Headings
        
        public static let title1 = UIFont.systemFont(ofSize: 28, weight: .bold)
        public static let title2 = UIFont.systemFont(ofSize: 22, weight: .bold)
        public static let title3 = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        // MARK: Body
        
        public static let body = UIFont.systemFont(ofSize: 17, weight: .regular)
        public static let bodyBold = UIFont.systemFont(ofSize: 17, weight: .semibold)
        public static let callout = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        // MARK: Small Text
        
        public static let subheadline = UIFont.systemFont(ofSize: 15, weight: .regular)
        public static let footnote = UIFont.systemFont(ofSize: 13, weight: .regular)
        public static let caption1 = UIFont.systemFont(ofSize: 12, weight: .regular)
        public static let caption2 = UIFont.systemFont(ofSize: 11, weight: .regular)
        
        // MARK: Dynamic Type Support
        
        public static func preferredFont(for style: UIFont.TextStyle) -> UIFont {
            return UIFont.preferredFont(forTextStyle: style)
        }
    }
    
    // MARK: - Spacing
    
    public enum Spacing {
        public static let xxxs: CGFloat = 2
        public static let xxs: CGFloat = 4
        public static let xs: CGFloat = 8
        public static let sm: CGFloat = 12
        public static let md: CGFloat = 16
        public static let lg: CGFloat = 24
        public static let xl: CGFloat = 32
        public static let xxl: CGFloat = 40
    }
    
    // MARK: - Corner Radius
    
    public enum CornerRadius {
        public static let xs: CGFloat = 4
        public static let sm: CGFloat = 8
        public static let md: CGFloat = 12
        public static let lg: CGFloat = 16
        public static let xl: CGFloat = 20
        public static let full: CGFloat = 999
    }
    
    // MARK: - Elevation (Shadows)
    
    public enum Elevation {
        
        public enum Level {
            case none
            case low
            case medium
            case high
        }
        
        public static func apply(_ level: Level, to layer: CALayer) {
            switch level {
            case .none:
                layer.shadowOpacity = 0
                
            case .low:
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 2)
                layer.shadowRadius = 4
                layer.shadowOpacity = 0.1
                
            case .medium:
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 4)
                layer.shadowRadius = 8
                layer.shadowOpacity = 0.15
                
            case .high:
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOffset = CGSize(width: 0, height: 8)
                layer.shadowRadius = 16
                layer.shadowOpacity = 0.2
            }
        }
    }
    
    // MARK: - Animation
    
    public enum Animation {
        public static let durationFast: TimeInterval = 0.15
        public static let durationNormal: TimeInterval = 0.3
        public static let durationSlow: TimeInterval = 0.5
        
        @MainActor
        public static func spring(
            duration: TimeInterval = durationNormal,
            animations: @escaping () -> Void,
            completion: ((Bool) -> Void)? = nil
        ) {
            UIView.animate(
                withDuration: duration,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.5,
                options: [.curveEaseInOut],
                animations: animations,
                completion: completion
            )
        }
    }
}
