//
//  UserManagement.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/5/22.
//

import Foundation

protocol UserManagement: Validator {
    var credentialDataAccess: CredentialDataAccess { get set }
    var userInfoDataAccess: UserInfoDataAccess { get set }
    func register(_ email: String, _ password: String, _ retypePassword: String, _ completion: @escaping (Result<String, Error>) -> Void)
}

struct UserManagementImpl: UserManagement {
    var credentialDataAccess: CredentialDataAccess
    var userInfoDataAccess: UserInfoDataAccess
    
    func register(_ email: String, _ password: String, _ retypePassword: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        do {
            try validateEmail(email)
            try validatePassword(password)
            try validatePasswordAndConfirmPassword(password, retypePassword)
        } catch {
            completion(.failure(error))
            return
        }
        
        // should use dispatch group/or ns operation queue
        credentialDataAccess.createCredential(email, password) { result in
            switch result {
            case .success(let credential):
                userInfoDataAccess.createUserInfo(credential.email) { result in
                    switch result {
                    case .success(_):
                        completion(.success(email))
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
