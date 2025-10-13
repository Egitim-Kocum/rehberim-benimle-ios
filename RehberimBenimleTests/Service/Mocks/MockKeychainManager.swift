//
//  MockKeychainManager.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

@testable import RehberimBenimle
import Foundation

final class MockKeychainManager: KeychainManagerProtocol {
    var service = "MockService"
    private var storage: [String: Data] = [:]
    
    func save<T>(_ item: T, forKey key: KeychainKeys) throws where T : Codable {
        storage[key.rawValue] = try JSONEncoder().encode(item)
    }
    
    func retrieve<T>(forKey key: KeychainKeys, as type: T.Type) throws -> T where T : Codable {
        guard let data = storage[key.rawValue] else {
            throw KeychainError.itemNotFound
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func delete(forKey key: KeychainKeys) throws {
        storage.removeValue(forKey: key.rawValue)
    }
    
    func exists(forKey key: KeychainKeys) -> Bool {
        storage[key.rawValue] != nil
    }
    
    func clearAll() {
        storage.removeAll()
    }
}
