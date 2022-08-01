//
//  UtilDI.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/4/22.
//

import Foundation

protocol UtilDI {
    func makeJSONEncoder() -> JSONEncoderProtocol
    func makeJSONDecoder() -> JSONDecoderProtocol
    func makeUserDefault() -> UserDefaultsProtocol
}

class UtilDIImpl: UtilDI {
    static let shared = UtilDIImpl()
    private init() {}
    
    func makeJSONDecoder() -> JSONDecoderProtocol {
        return JSONDecoder()
    }
    
    func makeJSONEncoder() -> JSONEncoderProtocol {
        return JSONEncoder()
    }
    
    func makeUserDefault() -> UserDefaultsProtocol {
        return UserDefaults.standard
    }
}
