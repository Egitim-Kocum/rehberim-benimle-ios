//
//  PersistenceManager.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Foundation

@MainActor
public final class PersistenceManager {
    public static let shared = PersistenceManager()
    
    public let keychain: KeychainManagerProtocol
    public let userDefaults: UserDefaultsManagerProtocol
    public let coreData: CoreDataManagerProtocol
    
    public init(
        keychain: KeychainManagerProtocol = KeychainManager.shared,
        userDefaults: UserDefaultsManagerProtocol = UserDefaultsManager.shared,
        coreData: CoreDataManagerProtocol = CoreDataManager.shared
    ) {
        self.keychain = keychain
        self.userDefaults = userDefaults
        self.coreData = coreData
    }
    
    public func clearAllData() throws {
        try keychain.delete(key: .authToken)
        try keychain.delete(key: .refreshToken)
        
        userDefaults.delete(key: .isLoggedIn)
        userDefaults.delete(key: .hasSeenOnboarding)
        userDefaults.delete(key: .userSettings)
    }
}
