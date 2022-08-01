//
//  UserInfoDataAccess.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/5/22.
//

import Foundation

enum UserInfoDataAccessError: Error {
    case userInfoNotFound
}

extension UserInfoDataAccessError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .userInfoNotFound:
            return NSLocalizedString("UserInfo is not existed", comment: "UserInfo Not Existed")
        }
    }
}

protocol UserInfoDataAccess: TableDataAccess {
    func createUserInfo(_ email: String, _ completion: @escaping (Result<UserInfo, Error>) -> Void)
    func fetchUserInfo(_ email: String, _ completion: @escaping (Result<UserInfo, Error>) -> Void)
}

struct UserInfoDataAccessImpl: UserInfoDataAccess {
    var jsonEncoder: JSONEncoderProtocol
    var jsonDecoder: JSONDecoderProtocol
    var userDefault: UserDefaultsProtocol
    
    struct Constants {
        static let tableName = "UserInfo"
    }
    
    func createUserInfo(_ email: String, _ completion: @escaping (Result<UserInfo, Error>) -> Void) {
        do {
            var userInfos = try readTable([UserInfoEntity].self,
                                                 Constants.tableName) ?? []
            
            let entity = UserInfoEntity(email: email, firstLogin: true)
            userInfos.append(entity)
            try saveTable(userInfos, Constants.tableName)
            completion(.success(entity.toDomain()))
        } catch {
            completion(.failure(error))
        }
    }
    
    func fetchUserInfo(_ email: String, _ completion: @escaping (Result<UserInfo, Error>) -> Void) {
        do {
            let userInfoEntities = try readTable([UserInfoEntity].self,
                                                 Constants.tableName) ?? []
            
            guard let userInfoEntity = userInfoEntities.first (where: { $0.email == email }) else {
                completion(.failure(UserInfoDataAccessError.userInfoNotFound))
                return
            }
            completion(.success(userInfoEntity.toDomain()))
        } catch {
            completion(.failure(error))
        }
    }
}
