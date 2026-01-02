//
//  UserDefaultsManager.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Foundation

public final class UserDefaultsManager: UserDefaultsManagerProtocol, @unchecked Sendable {
    
    public static let shared = UserDefaultsManager()
    
    private init() {}
    
    public func save<T: Codable>(_ value: T, key: UserDefaultsKey) throws {
        let data = try JSONEncoder().encode(value)
        UserDefaults.standard.set(data, forKey: key.rawValue)
    }
    
    public func get<T: Codable>(_ type: T.Type, key: UserDefaultsKey) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key.rawValue) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    public func delete(key: UserDefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    public func exists(key: UserDefaultsKey) -> Bool {
        return UserDefaults.standard.object(forKey: key.rawValue) != nil
    }
    
    public func saveBool(_ value: Bool, key: UserDefaultsKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    public func getBool(key: UserDefaultsKey) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
}
