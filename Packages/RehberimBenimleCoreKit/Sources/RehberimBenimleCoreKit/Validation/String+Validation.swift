//
//  String+Validation.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import Foundation

public extension String {

    func validateNotEmpty(fieldName: String) throws {
        if trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw ValidationError.empty(field: fieldName)
        }
    }

    func validateEmail() throws {
        
        try validateNotEmpty(fieldName: "Email")
        
        let regex =
        #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        if !predicate.evaluate(with: self) {
            throw ValidationError.invalidEmail
        }
    }

    func validatePassword(minLength: Int = 6) throws {
        
        try validateNotEmpty(fieldName: "Şifre")
        
        if count < minLength {
            throw ValidationError.passwordTooShort(min: minLength)
        }
    }
    
    func validateConfirmPassword(matches password: String) throws {
            try validateNotEmpty(fieldName: "Şifreyi Tekrarla")

            if self != password {
                throw ValidationError.passwordsDoNotMatch
            }
        }
}
