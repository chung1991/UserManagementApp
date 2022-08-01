//
//  Validator.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/5/22.
//

import Foundation

enum ValidatorError: Error {
    case emailInvalid(String)
    case passwordInvalid(String)
}

extension ValidatorError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emailInvalid(let message):
            return NSLocalizedString(message, comment: "Invalid email")
        case .passwordInvalid(let message):
            return NSLocalizedString(message, comment: "Invalid password")
        }
    }
}

protocol Validator {
    func validateEmail(_ email: String) throws
    func validatePassword(_ password: String) throws
    func validatePasswordAndConfirmPassword(_ password: String, _ confirmPassword: String) throws
}

extension Validator {
    func validateEmail(_ email: String) throws {
        if email.isEmpty {
            throw ValidatorError.emailInvalid("Email must not be empty")
        }
        
        if !email.isValidEmail() {
            throw ValidatorError.emailInvalid("Email is not valid format")
        }
    }
    
    func validatePassword(_ password: String) throws {
        if password.isEmpty {
            throw ValidatorError.passwordInvalid("Password must not be empty")
        }
        
        if password.count < 8 {
            throw ValidatorError.passwordInvalid("Password must at least 8 characters")
        }
        
        if !password.containsDigit() {
            throw ValidatorError.passwordInvalid("Password must at least 1 digit")
        }
        
        if !password.containsSpecialCharacter() {
            throw ValidatorError.passwordInvalid("Password must at least 1 special character")
        }
    }
    
    func validatePasswordAndConfirmPassword(_ password: String, _ confirmPassword: String) throws {
        if password != confirmPassword {
            throw ValidatorError.passwordInvalid("Password and Confirm Password must matched")
        }
    }
    
}
