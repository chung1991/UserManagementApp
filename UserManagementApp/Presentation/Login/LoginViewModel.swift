//
//  LoginViewModel.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/3/22.
//

import Foundation

protocol LoginViewModel {
    var authManagement: AuthManagement { get set }
    var currentCredential: Credential? { get set }
    func login(_ email: String, _ password: String, _ completion: @escaping (Error?) -> Void)
}

class LoginViewModelImpl: LoginViewModel {
    var authManagement: AuthManagement
    var currentCredential: Credential?
    
    init (authManagement: AuthManagement) {
        self.authManagement = authManagement
    }
    
    func login(_ email: String, _ password: String, _ completion: @escaping (Error?) -> Void) {
        authManagement.login(email,
                             password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let credential):
                self.currentCredential = credential
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}


