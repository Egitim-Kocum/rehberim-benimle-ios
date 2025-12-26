//
//  PersistenceManager.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Foundation

final class PersistenceManager {
    static let shared = PersistenceManager()
    
    let keychain: KeychainManagerProtocol
    let userDefaults: UserDefaultsManagerProtocol
    let coreData: CoreDataManagerProtocol
    
    init(keychain: KeychainManagerProtocol = KeychainManager.shared,
         userDefaults: UserDefaultsManagerProtocol = UserDefaultsManager.shared,
         coreData: CoreDataManagerProtocol = CoreDataManager.shared) {
        self.keychain = keychain
        self.userDefaults = userDefaults
        self.coreData = coreData
    }
    
    func clearAllData() throws {
        try keychain.delete(forKey: .authToken)
        try keychain.delete(forKey: .refreshToken)
        
        userDefaults.delete(forKey: .isLoggedIn)
        userDefaults.delete(forKey: .hasOnboardingSeen)
    }
}
