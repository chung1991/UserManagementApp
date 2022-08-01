//
//  String+Ext.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/3/22.
//

import Foundation

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    func isValidEmail() -> Bool {
        return matches("^(.+)@(.+)$")
    }
    
    func containsDigit() -> Bool {
        for c in self {
            if c.isDigit() { return true }
        }
        return false
    }
    
    func containsSpecialCharacter() -> Bool {
        for c in self {
            if c.isSpecialCharacter() { return true }
        }
        return false
    }
}
