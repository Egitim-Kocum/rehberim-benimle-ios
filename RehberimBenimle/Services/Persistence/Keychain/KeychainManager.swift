//
//  KeychainManager.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Foundation
import Security

final class KeychainManager: KeychainManagerProtocol {
    
    static let shared = KeychainManager()
    let service: String = Bundle.main.bundleIdentifier ?? "com.RehberimBenimle.keychainService"

    func save<T: Codable>(_ item: T, forKey key: KeychainKeys) throws {
        let data: Data = try JSONEncoder().encode(item)

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key.rawValue,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]

        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != errSecSuccess {
            throw KeychainError.saveFailed(status: status)
        }
    }
    
    func retrieve<T: Codable>(forKey key: KeychainKeys, as type: T.Type) throws -> T {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key.rawValue,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        guard status == errSecSuccess else {
            throw (status == errSecItemNotFound) ? KeychainError.itemNotFound : KeychainError.retrieveFailed(status: status)
        }

        guard let data = item as? Data else {
            throw KeychainError.dataConversionError
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func delete(forKey key: KeychainKeys) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key.rawValue
        ]

        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess && status != errSecItemNotFound {
            throw KeychainError.deleteFailed(status: status)
        }
    }
}
