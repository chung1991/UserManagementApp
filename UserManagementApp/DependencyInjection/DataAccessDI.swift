//
//  DataAccessDI.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/4/22.
//

import Foundation

protocol DataAccessDI {
    func makeCredentialDataAccess() -> CredentialDataAccess
    func makeUserInfoDataAccess() -> UserInfoDataAccess
}

struct DataAccessDIImpl: DataAccessDI {
    static let shared = DataAccessDIImpl()
    private init() {}
    func makeCredentialDataAccess() -> CredentialDataAccess {
        return CredentialDataAccessImpl(jsonEncoder: UtilDIImpl.shared.makeJSONEncoder(),
                                        jsonDecoder: UtilDIImpl.shared.makeJSONDecoder(),
                                        userDefault: UtilDIImpl.shared.makeUserDefault())
    }
    
    func makeUserInfoDataAccess() -> UserInfoDataAccess {
        return UserInfoDataAccessImpl(jsonEncoder: UtilDIImpl.shared.makeJSONEncoder(),
                                      jsonDecoder: UtilDIImpl.shared.makeJSONDecoder(),
                                      userDefault: UtilDIImpl.shared.makeUserDefault())
    }
}
