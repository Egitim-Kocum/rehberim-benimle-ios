//
//  LoginValidator.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 26.12.2025.
//

import RehberimBenimleCoreKit

protocol LoginValidatorProtocol {
    func validate(email: String?, password: String?) throws -> (email: String, password: String)
}

struct LoginValidator: LoginValidatorProtocol {
    func validate(email: String?, password: String?) throws -> (email: String, password: String) {
        guard let email else { throw ValidationError.empty(field: "Email") }
        try email.validateNotEmpty(fieldName: "Email")
        try email.validateEmail()
        
        guard let password else { throw ValidationError.empty(field: "Password") }
        try password.validateNotEmpty(fieldName: "Password")
        try password.validatePassword()
        
        return (email, password)
    }
}
