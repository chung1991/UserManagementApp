//
//  HomeViewModel.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/6/22.
//

import Foundation

protocol HomeViewModel {
    var credential: Credential? { get set }
    func setCredential(_ credential: Credential)
}

class HomeViewModelImpl: HomeViewModel {
    var credential: Credential?
    func setCredential(_ credential: Credential) {
        self.credential = credential
    }
}
