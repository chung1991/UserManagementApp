//
//  CredentialEntity.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/4/22.
//

import Foundation

struct CredentialEntity: Codable {
    let email: String
    let password: String
}

extension CredentialEntity {
    func toDomain() -> Credential {
        return Credential(email: email,
                          password: password)
    }
}
