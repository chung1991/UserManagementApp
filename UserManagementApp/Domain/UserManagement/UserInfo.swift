//
//  UserInfo.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/4/22.
//

import Foundation

class UserInfo {
    var firstLogin: Bool
    var firstName: String
    var lastName: String
    var address: String
    var city: String
    var state: String
    var mobile: String
    var idNumber: String
    weak var credential: Credential?
    
    init(firstLogin: Bool,
         firstName: String,
         lastName: String,
         address: String,
         city: String,
         state: String,
         mobile: String,
         idNumber: String) {
        
        self.firstLogin = firstLogin
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.city = city
        self.state = state
        self.mobile = mobile
        self.idNumber = idNumber
    }
}
