//
//  RegisterViewModel.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/5/22.
//

import Foundation

protocol RegisterViewModel {
    var userManangement: UserManagement { get set }
    func register(_ email: String, _ password: String, _ retypePassword: String, _ completion: @escaping (Error?)->Void)
}

struct RegisterViewModelImpl: RegisterViewModel {
    var userManangement: UserManagement
    
    func register(_ email: String, _ password: String, _ retypePassword: String, _ completion: @escaping (Error?)->Void) {
        userManangement.register(email, password, retypePassword) { result in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(_):
                completion(nil)
            }
        }
    }
}
