//
//  Character+Ext.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/3/22.
//

import Foundation

extension Character {
    private func isInRangeInclusive(_ from: Int, _ to: Int) -> Bool {
        let code = Int(self.asciiValue!)
        let gap = code - from
        return gap >= 0 && gap <= (to - from)
    }
    
    func isDigit() -> Bool {
        return isInRangeInclusive(48, 57)
    }
    
    func isSpecialCharacter() -> Bool {
        return isInRangeInclusive(33, 47)
                || isInRangeInclusive(58, 64)
                || isInRangeInclusive(91, 96)
                || isInRangeInclusive(123, 126)
    }
}
