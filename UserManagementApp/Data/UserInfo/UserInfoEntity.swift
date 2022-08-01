//
//  UserInfoEntity.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/4/22.
//

import Foundation

struct UserInfoEntity: Codable {
    let email: String
    let firstLogin: Bool
    let firstName: String
    let lastName: String
    let address: String
    let city: String
    let state: String
    let mobile: String
    let idNumber: String
    
    init (email: String, firstLogin: Bool) {
        self.firstLogin = firstLogin
        self.email = email
        self.firstName = ""
        self.lastName = ""
        self.address = ""
        self.city = ""
        self.state = ""
        self.mobile = ""
        self.idNumber = ""
    }
}

extension UserInfoEntity {
    func toDomain() -> UserInfo {
        return UserInfo(firstLogin: firstLogin,
                        firstName: firstName,
                        lastName: lastName,
                        address: address,
                        city: city,
                        state: state,
                        mobile: mobile,
                        idNumber: idNumber)
    }
}
