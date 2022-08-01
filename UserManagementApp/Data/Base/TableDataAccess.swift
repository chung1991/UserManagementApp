//
//  TableDataAccess.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/5/22.
//

import Foundation

protocol TableDataAccess {
    var jsonEncoder: JSONEncoderProtocol { get set }
    var jsonDecoder: JSONDecoderProtocol { get set }
    var userDefault: UserDefaultsProtocol { get set }
    
    func readTable<T: Decodable>(_ type: T.Type, _ tableName: String) throws -> T?
    func saveTable<T: Encodable>(_ data: T, _ tableName: String) throws
}

extension TableDataAccess {
    func readTable<T: Decodable>(_ type: T.Type, _ tableName: String) throws -> T? {
        guard let tableData = userDefault.value(forKey: tableName) as? Data else {
            return nil
        }
        return try jsonDecoder.decode(type, from: tableData)
    }
    
    func saveTable<T: Encodable>(_ data: T, _ tableName: String) throws {
        let data = try jsonEncoder.encode(data)
        userDefault.set(data, forKey: tableName)
    }
}
