//
//  Credential.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/3/22.
//

import Foundation

class Credential {
    let email: String
    let password: String
    var userInfo: UserInfo?
    
    init (email: String, password: String) {
        self.email = email
        self.password = password
    }
}
