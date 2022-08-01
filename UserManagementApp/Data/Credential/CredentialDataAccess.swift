//
//  CredentialDataAccess.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/4/22.
//

import Foundation

enum CredentialDataAccessError: Error {
    case credentialNotExisted
    case credentialNotAvailable
}

extension CredentialDataAccessError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .credentialNotExisted:
            return NSLocalizedString("Credential is not existed", comment: "Credential Not Existed")
        case .credentialNotAvailable:
            return NSLocalizedString("Credential is not available", comment: "Credential Not Available")
        }
    }
}

protocol CredentialDataAccess: TableDataAccess {
    func login(_ email: String, _ password: String, _ completion: @escaping (Result<Credential, Error>) -> Void)
    func createCredential(_ email: String, _ password: String, _ completion: @escaping (Result<Credential, Error>) -> Void)
}

struct CredentialDataAccessImpl: CredentialDataAccess {
    var jsonEncoder: JSONEncoderProtocol
    var jsonDecoder: JSONDecoderProtocol
    var userDefault: UserDefaultsProtocol
    
    struct Constants {
        static let tableName = "Credential"
    }
    
    // not cache user because of security issues
    func login(_ email: String, _ password: String, _ completion: @escaping (Result<Credential, Error>) -> Void) {
        do {
            let credentials = try readTable([CredentialEntity].self,
                                            Constants.tableName) ?? []
            for credential in credentials {
                if credential.email == email && credential.password == password {
                    completion(.success(credential.toDomain()))
                    return
                }
            }
            completion(.failure(CredentialDataAccessError.credentialNotExisted))
        } catch {
            completion(.failure(error))
        }
    }
    
    func createCredential(_ email: String, _ password: String, _ completion: @escaping (Result<Credential, Error>) -> Void) {
        do {
            var credentials = try readTable([CredentialEntity].self,
                                                   Constants.tableName) ?? []

            // if user same email already existed
            guard let _ = credentials.first(where: { $0.email == email }) else {
                let entity = CredentialEntity(email: email,
                                              password: password)
                credentials.append(entity)
                try saveTable(credentials, Constants.tableName)
                completion(.success(entity.toDomain()))
                return
            }
            completion(.failure(CredentialDataAccessError.credentialNotAvailable))
        } catch {
            completion(.failure(error))
        }
    }
}
