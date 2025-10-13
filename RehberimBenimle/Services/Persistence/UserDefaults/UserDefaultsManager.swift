//
//  UserDefaultsManager.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Foundation

final class UserDefaultsManager: UserDefaultsManagerProtocol {
    
    static let shared = UserDefaultsManager()
    let defaults: UserDefaults = .standard
    
    func save<T: Codable>(_ value: T, forKey key: UserDefaultsKeys) throws {
        let data = try JSONEncoder().encode(value)
        defaults.set(data, forKey: key.rawValue)
    }
    
    func retrieve<T: Codable>(forKey key: UserDefaultsKeys, as type: T.Type) throws -> T? {
        guard let data = defaults.data(forKey: key.rawValue) else {
            return nil
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
