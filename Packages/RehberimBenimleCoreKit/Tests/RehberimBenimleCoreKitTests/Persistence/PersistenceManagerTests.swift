//
//  PersistenceManagerTests.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Testing
@testable import RehberimBenimleCoreKit
import CoreData
//
//@Suite("PersistenceManager Tests")
//@MainActor
//struct PersistenceManagerTests {
//    private let manager: PersistenceManager
//    
//    private let mockKeychain = MockKeychainManager()
//    private let mockUserDefaults = MockUserDefaultsManager()
//    private let mockCoreData = MockCoreDataManager()
//    
//    init() {
//        manager = PersistenceManager(
//            keychain: mockKeychain,
//            userDefaults: mockUserDefaults,
//            coreData: mockCoreData
//        )
//    }
//    
//    @Test("Should clear all data")
//    func test_PersistenceManager_clearAll_shouldRemoveAllData() throws {
//        // Given
//        try mockKeychain.save("token", key: .authToken)
//        mockUserDefaults.saveBool(true, key: .isLoggedIn)
//        
//        // When
//        try manager.clearAllData()
//        
//        // Then
//        let tokenExists = mockKeychain.exists(key: .authToken)
//        let loginExists = mockUserDefaults.exists(key: .isLoggedIn)
//        
//        #expect(tokenExists == false)
//        #expect(loginExists == false)
//    }
//    
//    @Test("Should inject dependencies correctly")
//    func test_PersistenceManager_init_shouldInjectDependencies() {
//        // Then
//        #expect(manager.keychain is MockKeychainManager)
//        #expect(manager.userDefaults is MockUserDefaultsManager)
//        #expect(manager.coreData is MockCoreDataManager)
//    }
//    
//    @Test("Should test keychain access")
//    func test_PersistenceManager_keychain_shouldAccessKeychainStorage() throws {
//        // When
//        try manager.keychain.save("test-token", key: .authToken)
//        let token: String = try manager.keychain.get(String.self, key: .authToken)
//        
//        // Then
//        #expect(token == "test-token")
//    }
//    
//    @Test("Should test userDefaults access")
//    func test_PersistenceManager_userDefaults_shouldAccessUserDefaultsStorage() {
//        // When
//        manager.userDefaults.saveBool(true, key: .isLoggedIn)
//        let isLoggedIn = manager.userDefaults.getBool(key: .isLoggedIn)
//        
//        // Then
//        #expect(isLoggedIn == true)
//    }
//    
//    @Test("Should test coreData access")
//    func test_PersistenceManager_coreData_shouldAccessCoreDataStorage() throws {
//        // When
//        let object = manager.coreData.create(NSManagedObject.self)
//        
//        // Then
//        #expect(object.managedObjectContext != nil)
//    }
//}
