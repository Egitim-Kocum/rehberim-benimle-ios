//
//  PersistenceManagerTests.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Testing
@testable import RehberimBenimle

@Suite("PersistenceManager Tests")
struct PersistenceManagerTests {
    var sut: PersistenceManager!
    var keychain: MockKeychainManager!
    var userDefaults: MockUserDefaultsManager!
    var coreData: MockCoreDataManager!
    
    init() {
        keychain = MockKeychainManager()
        userDefaults = MockUserDefaultsManager()
        coreData = MockCoreDataManager()
        sut = PersistenceManager(keychain: keychain, userDefaults: userDefaults, coreData: coreData)
    }
    
    @Test("ClearAllData deletes tokens and flags")
    func testClearAllData() async throws {
        struct Token: Codable { let t: String }
        try keychain.save(Token(t: "abc"), forKey: .authToken)
        try keychain.save(Token(t: "def"), forKey: .refreshToken)
        
        try userDefaults.save(true, forKey: .isLoggedIn)
        try userDefaults.save(true, forKey: .hasOnboardingSeen)
        
        try sut.clearAllData()
        
        #expect(!keychain.exists(forKey: .authToken))
        #expect(!keychain.exists(forKey: .refreshToken))
        
        #expect(!userDefaults.exists(forKey: .isLoggedIn))
        #expect(!userDefaults.exists(forKey: .hasOnboardingSeen))
    }
}
