//
//  UserDefaultsManagerProtocol.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Foundation

enum UserDefaultsKeys: String {
    case isLoggedIn = "isLoggedIn"
    case hasOnboardingSeen = "hasOnboardingSeen"
}

protocol UserDefaultsManagerProtocol {
    var defaults: UserDefaults { get }

    func save<T: Codable>(_ value: T, forKey key: UserDefaultsKeys) throws
    func retrieve<T: Codable>(forKey key: UserDefaultsKeys, as type: T.Type) throws -> T?
    func delete(forKey key: UserDefaultsKeys)
    func exists(forKey key: UserDefaultsKeys) -> Bool
}

extension UserDefaultsManagerProtocol {
    func exists(forKey key: UserDefaultsKeys) -> Bool {
        defaults.object(forKey: key.rawValue) != nil
    }
    
    func delete(forKey key: UserDefaultsKeys) {
        defaults.removeObject(forKey: key.rawValue)
    }
}
