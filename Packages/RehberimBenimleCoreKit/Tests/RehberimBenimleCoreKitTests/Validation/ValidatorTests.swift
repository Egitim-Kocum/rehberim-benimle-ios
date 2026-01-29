//
//  ValidatorTests.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 24.12.2025.
//

import Testing
@testable import RehberimBenimleCoreKit

@Suite("Validator Tests")
struct ValidatorTests {
    
    // MARK: - validateNotEmpty Tests
    
    @Test
    func test_validateNotEmpty_withEmptyString_throwsValidationError() throws {
        let emptyString: String = ""
        
        do {
            try emptyString.validateNotEmpty(fieldName: "Test Field")
            Issue.record("Expected ValidationError.empty to be thrown")
        } catch ValidationError.empty(let field) {
            #expect(field == "Test Field")
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validateNotEmpty_withWhitespaceString_throwsValidationError() throws {
        let whitespaceString: String = " "
        
        do {
            try whitespaceString.validateNotEmpty(fieldName: "Test Field")
            Issue.record("Expected ValidationError.empty to be thrown")
        } catch ValidationError.empty(let field) {
            #expect(field == "Test Field")
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validateNotEmpty_withMultipleWhitespaces_throwsValidationError() throws {
        let whitespaceString = "     "
        
        do {
            try whitespaceString.validateNotEmpty(fieldName: "Test Field")
            Issue.record("Expected ValidationError.empty to be thrown")
        } catch ValidationError.empty(let field) {
            #expect(field == "Test Field")
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validateNotEmpty_withTabsAndSpaces_throwsValidationError() throws {
        let whitespaceString = "\t  \n  "
        
        do {
            try whitespaceString.validateNotEmpty(fieldName: "Test Field")
            Issue.record("Expected ValidationError.empty to be thrown")
        } catch ValidationError.empty(let field) {
            #expect(field == "Test Field")
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validateNotEmpty_withString_passesValidation() throws {
        let string = "abc"
    
        try string.validateNotEmpty(fieldName: "Text Field")
    }
    
    @Test
    func test_validateNotEmpty_withStringContainingWhitespace_passesValidation() throws {
        let string = "abc def"
        
        try string.validateNotEmpty(fieldName: "Test Field")
    }
    
    @Test
    func test_validateNotEmpty_withDifferentFieldName_throwsCorrectError() throws {
        let emptyString = ""
        
        do {
            try emptyString.validateNotEmpty(fieldName: "Email")
            Issue.record("Expected ValidationError.empty to be thrown")
        } catch ValidationError.empty(let field) {
            #expect(field == "Email")
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    // MARK: - validateEmail Tests
    
    @Test
    func test_validateEmail_withValidEmail_passesValidation() throws {
        let validEmail = "test@example.com"
        
        try validEmail.validateEmail()
    }
    
    @Test
    func test_validateEmail_withValidEmailWithDot_passesValidation() throws {
        let validEmail = "test.user@example.com"
        
        try validEmail.validateEmail()
    }
    
    @Test
    func test_validateEmail_withValidEmailWithPlus_passesValidation() throws {
        let validEmail = "test+user@example.com"
        
        try validEmail.validateEmail()
    }
    
    @Test
    func test_validateEmail_withValidEmailWithUnderscore_passesValidation() throws {
        let validEmail = "test_user@example.com"
        
        try validEmail.validateEmail()
    }
    
    @Test
    func test_validateEmail_withValidEmailWithHyphen_passesValidation() throws {
        let validEmail = "test@ex-ample.com"
        
        try validEmail.validateEmail()
    }
    
    @Test
    func test_validateEmail_withValidEmailWithNumbers_passesValidation() throws {
        let validEmail = "test123@example456.com"
        
        try validEmail.validateEmail()
    }
    
    @Test
    func test_validateEmail_withMaxLengthEmail_passesValidation() throws {
        let validEmail = "verylongemailaddress@verylongdomainname.com"
        
        try validEmail.validateEmail()
    }
    
    @Test
    func test_validateEmail_withInvalidEmail_throwsValidationError() throws {
        let invalidEmail = "invalid-email"
        
        do {
            try invalidEmail.validateEmail()
            Issue.record("Expected ValidationError.invalidEmail to be thrown")
        } catch ValidationError.invalidEmail {
            // Başarılı - doğru hata fırlatıldı
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validateEmail_withNoAtSign_throwsValidationError() throws {
        let invalidEmail = "testexample.com"
        
        do {
            try invalidEmail.validateEmail()
            Issue.record("Expected ValidationError.invalidEmail to be thrown")
        } catch ValidationError.invalidEmail {
            // Başarılı
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validateEmail_withNoDomain_throwsValidationError() throws {
        let invalidEmail = "test@"
        
        do {
            try invalidEmail.validateEmail()
            Issue.record("Expected ValidationError.invalidEmail to be thrown")
        } catch ValidationError.invalidEmail {
            // Başarılı
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validateEmail_withNoTLD_throwsValidationError() throws {
        let invalidEmail = "test@example"
        
        do {
            try invalidEmail.validateEmail()
            Issue.record("Expected ValidationError.invalidEmail to be thrown")
        } catch ValidationError.invalidEmail {
            // Başarılı
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validateEmail_withMultipleAtSigns_throwsValidationError() throws {
        let invalidEmail = "test@@example.com"
        
        do {
            try invalidEmail.validateEmail()
            Issue.record("Expected ValidationError.invalidEmail to be thrown")
        } catch ValidationError.invalidEmail {
            // Başarılı
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validateEmail_withSpaces_throwsValidationError() throws {
        let invalidEmail = "test @example.com"
        
        do {
            try invalidEmail.validateEmail()
            Issue.record("Expected ValidationError.invalidEmail to be thrown")
        } catch ValidationError.invalidEmail {
            // Başarılı
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validateEmail_withLeadingSpaces_throwsValidationError() throws {
        let invalidEmail = " test@example.com"
        
        do {
            try invalidEmail.validateEmail()
            Issue.record("Expected ValidationError.invalidEmail to be thrown")
        } catch ValidationError.invalidEmail {
            // Başarılı
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validateEmail_withTrailingSpaces_throwsValidationError() throws {
        let invalidEmail = "test@example.com "
        
        do {
            try invalidEmail.validateEmail()
            Issue.record("Expected ValidationError.invalidEmail to be thrown")
        } catch ValidationError.invalidEmail {
            // Başarılı
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validateEmail_withEmptyString_throwsValidationError() throws {
        let invalidEmail = ""
        
        do {
            try invalidEmail.validateEmail()
            Issue.record("Expected ValidationError.invalidEmail to be thrown")
        } catch ValidationError.empty(field: "Email") {
            // Başarılı
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validateEmail_withOnlyAtSign_throwsValidationError() throws {
        let invalidEmail = "@"
        
        do {
            try invalidEmail.validateEmail()
            Issue.record("Expected ValidationError.invalidEmail to be thrown")
        } catch ValidationError.invalidEmail {
            // Başarılı
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validateEmail_withMissingLocalPart_throwsValidationError() throws {
        let invalidEmail = "@example.com"
        
        do {
            try invalidEmail.validateEmail()
            Issue.record("Expected ValidationError.invalidEmail to be thrown")
        } catch ValidationError.invalidEmail {
            // Başarılı
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validateEmail_withInvalidTLD_throwsValidationError() throws {
        let invalidEmail = "test@example.c"
        
        do {
            try invalidEmail.validateEmail()
            Issue.record("Expected ValidationError.invalidEmail to be thrown")
        } catch ValidationError.invalidEmail {
            // Başarılı
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    // MARK: - validatePassword Tests
    
    @Test
    func test_validatePassword_withValidPassword_passesValidation() throws {
        let validPassword = "Strong@123"
        
        try validPassword.validatePassword()
    }
    
    @Test
    func test_validatePassword_withExactMinLength_passesValidation() throws {
        let password = "abc123" // Exactly 6 characters
        
        try password.validatePassword()
    }
    
    @Test
    func test_validatePassword_withExactMinLength_withCustomMin_passesValidation() throws {
        let password = "abcd" // Exactly 4 characters
        
        try password.validatePassword(minLength: 4)
    }
    
    @Test
    func test_validatePassword_withLongPassword_passesValidation() throws {
        let longPassword = String(repeating: "a", count: 100)
        
        try longPassword.validatePassword()
    }
    
    @Test
    func test_validatePassword_withVeryLongPassword_passesValidation() throws {
        let longPassword = String(repeating: "a", count: 1000)
        
        try longPassword.validatePassword()
    }
    
    @Test
    func test_validatePassword_withSetMinLength_withValidPassword_passesValidation() throws {
        let validPassword = "abc1"
        
        try validPassword.validatePassword(minLength: 4)
    }
    
    @Test
    func test_validatePassword_withZeroMinLength_withEmptyPassword_failedValidation() throws {
        let password = ""
        
        do {
            try password.validatePassword(minLength: 0)
        } catch ValidationError.empty(field: "Şifre") {
            
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validatePassword_withWeakPassword_throwsValidationError() throws {
        let weakPassword = "weak"
        
        do {
            try weakPassword.validatePassword()
            Issue.record("Expected ValidationError.passwordTooShort to be thrown")
        } catch ValidationError.passwordTooShort(let min) {
            #expect(min == 6)
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validatePassword_withEmptyPassword_throwsValidationError() throws {
        let emptyPassword = ""
        
        do {
            try emptyPassword.validatePassword()
            Issue.record("Expected ValidationError.passwordTooShort to be thrown")
        } catch ValidationError.empty(field: "Şifre") {
            
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validatePassword_withOneLessThanMinLength_throwsValidationError() throws {
        let password = "abcde" // 5 characters
        
        do {
            try password.validatePassword() // default min is 6
            Issue.record("Expected ValidationError.passwordTooShort to be thrown")
        } catch ValidationError.passwordTooShort(let min) {
            #expect(min == 6)
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validatePassword_withWhitespacePassword_throwsValidationError() throws {
        let whitespacePassword = "     " // 5 spaces
        
        do {
            try whitespacePassword.validatePassword()
            Issue.record("Expected ValidationError.passwordTooShort to be thrown")
        } catch ValidationError.empty(field: "Şifre") {
            
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validatePassword_withSetMinLength_withWeakPassword_throwsValidationError() throws {
        let weakPassword = "abc"
        
        do {
            try weakPassword.validatePassword(minLength: 4)
            Issue.record("Expected ValidationError.passwordTooShort to be thrown")
        } catch ValidationError.passwordTooShort(let min) {
            #expect(min == 4)
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validatePassword_withSingleCharacter_throwsValidationError() throws {
        let singleChar = "a"
        
        do {
            try singleChar.validatePassword()
            Issue.record("Expected ValidationError.passwordTooShort to be thrown")
        } catch ValidationError.passwordTooShort(let min) {
            #expect(min == 6)
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    @Test
    func test_validatePassword_withCustomMinLength_throwsCorrectError() throws {
        let password = "abc"
        
        do {
            try password.validatePassword(minLength: 10)
            Issue.record("Expected ValidationError.passwordTooShort to be thrown")
        } catch ValidationError.passwordTooShort(let min) {
            #expect(min == 10)
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }
    
    // MARK: - validateConfirmPassword Tests

    @Test
    func test_validateConfirmPassword_withMatchingPasswords_passesValidation() throws {
        let password = "Strong123"
        let confirmPassword = "Strong123"
        
        try confirmPassword.validateConfirmPassword(matches: password)
    }

    @Test
    func test_validateConfirmPassword_withDifferentPasswords_throwsValidationError() throws {
        let password = "Strong123"
        let confirmPassword = "Wrong123"
        
        do {
            try confirmPassword.validateConfirmPassword(matches: password)
            Issue.record("Expected ValidationError.passwordsDoNotMatch to be thrown")
        } catch ValidationError.passwordsDoNotMatch {
            // Success
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }

    @Test
    func test_validateConfirmPassword_withEmptyConfirmPassword_throwsEmptyError() throws {
        let password = "Strong123"
        let confirmPassword = ""
        
        do {
            try confirmPassword.validateConfirmPassword(matches: password)
            Issue.record("Expected ValidationError.empty to be thrown")
        } catch ValidationError.empty(let field) {
            #expect(field == "Şifreyi Tekrarla")
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }

    @Test
    func test_validateConfirmPassword_withWhitespaceConfirmPassword_throwsEmptyError() throws {
        let password = "Strong123"
        let confirmPassword = "   "
        
        do {
            try confirmPassword.validateConfirmPassword(matches: password)
            Issue.record("Expected ValidationError.empty to be thrown")
        } catch ValidationError.empty(let field) {
            #expect(field == "Şifreyi Tekrarla")
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }

    @Test
    func test_validateConfirmPassword_withEmptyPasswordAndConfirmPassword_throwsEmptyError() throws {
        let password = ""
        let confirmPassword = ""
        
        do {
            try confirmPassword.validateConfirmPassword(matches: password)
            Issue.record("Expected ValidationError.empty to be thrown")
        } catch ValidationError.empty(let field) {
            #expect(field == "Şifreyi Tekrarla")
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }

    @Test
    func test_validateConfirmPassword_withConfirmPasswordShorterThanPassword_throwsPasswordsDoNotMatch() throws {
        let password = "StrongPassword"
        let confirmPassword = "Strong"
        
        do {
            try confirmPassword.validateConfirmPassword(matches: password)
            Issue.record("Expected ValidationError.passwordsDoNotMatch to be thrown")
        } catch ValidationError.passwordsDoNotMatch {
            // Success
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }

    @Test
    func test_validateConfirmPassword_withDifferentCasePasswords_throwsPasswordsDoNotMatch() throws {
        let password = "Strong123"
        let confirmPassword = "strong123"
        
        do {
            try confirmPassword.validateConfirmPassword(matches: password)
            Issue.record("Expected ValidationError.passwordsDoNotMatch to be thrown")
        } catch ValidationError.passwordsDoNotMatch {
            // Success
        } catch {
            Issue.record("Unexpected error type: \(error)")
        }
    }

    @Test
    func test_validateConfirmPassword_withSpecialCharactersAndMatching_passesValidation() throws {
        let password = "!@#Password123"
        let confirmPassword = "!@#Password123"
        
        try confirmPassword.validateConfirmPassword(matches: password)
    }
}
