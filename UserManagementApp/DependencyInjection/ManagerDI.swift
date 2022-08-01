//
//  ManagerDI.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/3/22.
//

import Foundation

protocol ManagerDI {
    func makeAuthManagement() -> AuthManagement
    func makeUserManagement() -> UserManagement
}

class ManagerDIImpl: ManagerDI {
    static let shared = ManagerDIImpl()
    private init() {}
    func makeAuthManagement() -> AuthManagement {
        return AuthManagementImpl(credentialDataAccess: DataAccessDIImpl.shared.makeCredentialDataAccess(),
                                  userInfoDataAccess: DataAccessDIImpl.shared.makeUserInfoDataAccess())
    }
    
    func makeUserManagement() -> UserManagement {
        return UserManagementImpl(credentialDataAccess: DataAccessDIImpl.shared.makeCredentialDataAccess(),
                                  userInfoDataAccess: DataAccessDIImpl.shared.makeUserInfoDataAccess())
    }
}
