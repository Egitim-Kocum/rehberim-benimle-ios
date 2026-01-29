//
//  MockKeychainManager.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

@testable import RehberimBenimleCoreKit
import Foundation

final class MockKeychainManager: KeychainManagerProtocol, @unchecked Sendable {
    private var storage: [String: Data] = [:]
    private let lock = NSLock()
    
    func save<T: Codable>(_ value: T, key: KeychainKey) throws {
        let data = try JSONEncoder().encode(value)
        lock.lock()
        defer { lock.unlock() }
        storage[key.rawValue] = data
    }
    
    func get<T: Codable>(_ type: T.Type, key: KeychainKey) throws -> T {
        lock.lock()
        defer { lock.unlock() }
        guard let data = storage[key.rawValue] else {
            throw KeychainError.notFound
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func delete(key: KeychainKey) throws {
        lock.lock()
        defer { lock.unlock() }
        storage.removeValue(forKey: key.rawValue)
    }
    
    func exists(key: KeychainKey) -> Bool {
        lock.lock()
        defer { lock.unlock() }
        return storage[key.rawValue] != nil
    }
}
