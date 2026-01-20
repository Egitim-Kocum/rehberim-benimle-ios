//
//  SignupValidator.swift
//  RehberimBenimleFeatures
//
//  Created by Okan Orkun on 19.01.2026.
//

import RehberimBenimleCoreKit
import RehberimBenimleUI

protocol SignupValidatorProtocol {
    func validate(role: UserType?, fullName: String?, email: String?, password: String?, confirmPassword: String?) throws -> (role: String, fullName: String, email: String, password: String)
}

struct SignupValidator: SignupValidatorProtocol {
    func validate(role: UserType?, fullName: String?, email: String?, password: String?, confirmPassword: String?) throws -> (role: String, fullName: String, email: String, password: String) {
        
        guard let role, role.isValid else {
            throw ValidationError.notSelected(field: "Kullanıcı Türü")
        }
        
        guard let fullName else { throw ValidationError.empty(field: "İsim") }
        try fullName.validateNotEmpty(fieldName: "İsim")
        
        guard let email else { throw ValidationError.empty(field: "Email") }
        try email.validateEmail()
        
        guard let password else { throw ValidationError.empty(field: "Şifre") }
        try password.validatePassword()
        
        guard let confirmPassword else { throw ValidationError.empty(field: "Şifreyi Tekrarla") }
        
        try confirmPassword.validateConfirmPassword(matches: password)
        
        return (role.itemTitle, fullName, email, password)
        
    }
}
