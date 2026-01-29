//
//  MockUserDefaultsManager.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Foundation
@testable import RehberimBenimleCoreKit

final class MockUserDefaultsManager: UserDefaultsManagerProtocol, @unchecked Sendable {
    private var storage: [String: Data] = [:]
    private var boolStorage: [String: Bool] = [:]
    private let lock = NSLock()
    
    func save<T: Codable>(_ value: T, key: UserDefaultsKey) throws {
        let data = try JSONEncoder().encode(value)
        lock.lock()
        defer { lock.unlock() }
        storage[key.rawValue] = data
    }
    
    func get<T: Codable>(_ type: T.Type, key: UserDefaultsKey) -> T? {
        lock.lock()
        defer { lock.unlock() }
        guard let data = storage[key.rawValue] else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func delete(key: UserDefaultsKey) {
        lock.lock()
        defer { lock.unlock() }
        storage.removeValue(forKey: key.rawValue)
        boolStorage.removeValue(forKey: key.rawValue)
    }
    
    func exists(key: UserDefaultsKey) -> Bool {
        lock.lock()
        defer { lock.unlock() }
        return storage[key.rawValue] != nil || boolStorage[key.rawValue] != nil
    }
    
    func saveBool(_ value: Bool, key: UserDefaultsKey) {
        lock.lock()
        defer { lock.unlock() }
        boolStorage[key.rawValue] = value
    }
    
    func getBool(key: UserDefaultsKey) -> Bool {
        lock.lock()
        defer { lock.unlock() }
        return boolStorage[key.rawValue] ?? false
    }
}
