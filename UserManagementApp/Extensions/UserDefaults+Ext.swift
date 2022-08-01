//
//  UserDefaults+Ext.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/4/22.
//

import Foundation

protocol UserDefaultsProtocol {
    func set(_ value: Any?, forKey defaultName: String)
    func value(forKey key: String) -> Any?
}

extension UserDefaults: UserDefaultsProtocol {
}
