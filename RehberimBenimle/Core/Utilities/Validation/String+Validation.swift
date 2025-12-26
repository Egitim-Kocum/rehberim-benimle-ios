//
//  String+Validation.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import Foundation

extension String {

    func validateNotEmpty(fieldName: String) throws {
        if trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            throw ValidationError.empty(field: fieldName)
        }
    }

    func validateEmail() throws {
        let regex =
        #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)

        if !predicate.evaluate(with: self) {
            throw ValidationError.invalidEmail
        }
    }

    func validatePassword(minLength: Int = 6) throws {
        if count < minLength {
            throw ValidationError.passwordTooShort(min: minLength)
        }
    }
}
