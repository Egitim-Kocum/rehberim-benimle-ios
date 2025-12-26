//
//  ValidationError.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import Foundation

enum ValidationError: LocalizedError {
    case empty(field: String)
    case invalidEmail
    case passwordTooShort(min: Int)

    var errorDescription: String? {
        switch self {
        case .empty(let field):
            return "\(field) boş olamaz."
        case .invalidEmail:
            return "Geçerli bir email adresi giriniz."
        case .passwordTooShort(let min):
            return "Şifre en az \(min) karakter olmalıdır."
        }
    }
}
