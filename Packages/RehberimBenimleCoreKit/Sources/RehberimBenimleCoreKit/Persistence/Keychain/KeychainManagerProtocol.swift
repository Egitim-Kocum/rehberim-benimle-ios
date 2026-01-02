//
//  KeychainManagerProtocol.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Foundation
import Security

public enum KeychainKey: String {
    case authToken
    case refreshToken
}

public enum KeychainError: Error {
    case encodingFailed
    case decodingFailed
    case saveFailed
    case notFound
    case deleteFailed
}

public protocol KeychainManagerProtocol: Sendable {
    func save<T: Codable>(_ value: T, key: KeychainKey) throws
    func get<T: Codable>(_ type: T.Type, key: KeychainKey) throws -> T
    func delete(key: KeychainKey) throws
    func exists(key: KeychainKey) -> Bool
}
