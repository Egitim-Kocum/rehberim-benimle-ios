//
//  UserDefaultsManagerProtocol.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Foundation

public enum UserDefaultsKey: String {
    case isLoggedIn
    case hasSeenOnboarding
    case userSettings
}

public protocol UserDefaultsManagerProtocol: Sendable {
    func save<T: Codable>(_ value: T, key: UserDefaultsKey) throws
    func get<T: Codable>(_ type: T.Type, key: UserDefaultsKey) -> T?
    func delete(key: UserDefaultsKey)
    func exists(key: UserDefaultsKey) -> Bool
    func saveBool(_ value: Bool, key: UserDefaultsKey)
    func getBool(key: UserDefaultsKey) -> Bool
}
