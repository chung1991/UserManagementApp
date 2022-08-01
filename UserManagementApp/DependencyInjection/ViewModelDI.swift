//
//  ViewModelDI.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/3/22.
//

import Foundation

protocol ViewModelDI {
    func makeLoginViewModel() -> LoginViewModel
    func makeRegisterViewModel() -> RegisterViewModel
    func makeHomeViewModel() -> HomeViewModel
}

class ViewModelDIImpl: ViewModelDI {
    static let shared = ViewModelDIImpl()
    private init() {}
    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModelImpl(authManagement: ManagerDIImpl.shared.makeAuthManagement())
    }
    func makeRegisterViewModel() -> RegisterViewModel {
        return RegisterViewModelImpl(userManangement: ManagerDIImpl.shared.makeUserManagement())
    }
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModelImpl()
    }
}
