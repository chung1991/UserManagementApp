//
//  JSON+Ext.swift
//  UserManagementApp
//
//  Created by Chung Nguyen on 6/4/22.
//

import Foundation

protocol JSONEncoderProtocol {
    func encode<T>(_ value: T) throws -> Data where T : Encodable
}

protocol JSONDecoderProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONDecoder: JSONDecoderProtocol {
}

extension JSONEncoder: JSONEncoderProtocol {
}
