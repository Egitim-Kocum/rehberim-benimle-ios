//
//  KeychainManagerProtocol.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Foundation
import Security

enum KeychainKeys: String {
    case authToken = "kAuthToken"
    case refreshToken = "kRefreshToken"
}

enum KeychainError: Error {
    case dataConversionError
    case saveFailed(status: OSStatus)
    case retrieveFailed(status: OSStatus)
    case deleteFailed(status: OSStatus)
    case itemNotFound
}

protocol KeychainManagerProtocol {
    var service: String { get }

    func save<T: Codable>(_ item: T, forKey key: KeychainKeys) throws
    func retrieve<T: Codable>(forKey key: KeychainKeys, as type: T.Type) throws -> T
    func delete(forKey key: KeychainKeys) throws
    func exists(forKey key: KeychainKeys) -> Bool
}

extension KeychainManagerProtocol {
    func exists(forKey key: KeychainKeys) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: false
        ]
        return SecItemCopyMatching(query as CFDictionary, nil) == errSecSuccess
    }
}
