//
//  AuthManagement.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/3/22.
//

import Foundation

protocol AuthManagement: Validator {
    var credentialDataAccess: CredentialDataAccess { get set }
    var userInfoDataAccess: UserInfoDataAccess { get set }
    func login(_ email: String, _ password: String, _ completion: @escaping (Result<Credential, Error>) -> Void)
}

struct AuthManagementImpl: AuthManagement {
    var credentialDataAccess: CredentialDataAccess
    var userInfoDataAccess: UserInfoDataAccess
    
    func login(_ email: String, _ password: String, _ completion: @escaping (Result<Credential, Error>) -> Void) {
        do {
            try validateEmail(email)
            try validatePassword(password)
        } catch {
            completion(.failure(error))
            return
        }
        
        credentialDataAccess.login(email, password) { result in
            switch result {
            case .success(let credential):
                userInfoDataAccess.fetchUserInfo(email) { result in
                    switch result {
                    case .success(let userInfo):
                        credential.userInfo = userInfo
                        completion(.success(credential))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
