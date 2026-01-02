//
//  UserDefaultsManagerTests.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Testing
@testable import RehberimBenimleCoreKit

@Suite("UserDefaultsManager Tests")
struct UserDefaultsManagerTests {
    let storage = MockUserDefaultsManager()
    
    @Test("Should be able to save and retrieve a boolean value")
    func test_UserDefaultsManager_saveBool_shouldStoreValue() {
        // Given
        let value = true
        
        // When
        storage.saveBool(value, key: .isLoggedIn)
        let retrieved = storage.getBool(key: .isLoggedIn)
        
        // Then
        #expect(retrieved == value)
    }
    
    @Test("Should be able to save and retrieve a Codable object")
    func test_UserDefaultsManager_save_shouldStoreCodableObject() throws {
        // Given
        struct Settings: Codable, Equatable {
            let theme: String
            let notifications: Bool
        }
        let settings = Settings(theme: "dark", notifications: true)
        
        // When
        try storage.save(settings, key: .userSettings)
        let retrieved: Settings? = storage.get(Settings.self, key: .userSettings)
        
        // Then
        #expect(retrieved == settings)
    }
    
    @Test("Should return nil when trying to retrieve a non-existent value")
    func test_UserDefaultsManager_get_shouldReturnNil() {
        // When
        let result: String? = storage.get(String.self, key: .hasSeenOnboarding)
        
        // Then
        #expect(result == nil)
    }
    
    @Test("Should be able to delete a saved value")
    func test_UserDefaultsManager_delete_shouldRemoveValue() throws {
        // Given
        try storage.save("test", key: .userSettings)
        
        // When
        storage.delete(key: .userSettings)
        
        // Then
        let exists = storage.exists(key: .userSettings)
        #expect(exists == false)
    }
    
    @Test("Should be able to check if a value exists")
    func test_UserDefaultsManager_exists_shouldReturnTrue() throws {
        // Given
        try storage.save("test", key: .userSettings)
        
        // When
        let exists = storage.exists(key: .userSettings)
        
        // Then
        #expect(exists == true)
    }
    
    @Test("Should be able to check if a value exists - false case")
    func test_UserDefaultsManager_exists_shouldReturnFalse() {
        // When
        let exists = storage.exists(key: .hasSeenOnboarding)
        
        // Then
        #expect(exists == false)
    }
    
    @Test("Should return false for non-existent key when getting a Bool")
    func test_UserDefaultsManager_getBool_shouldReturnFalseForNonExistentKey() {
        // When
        let result = storage.getBool(key: .isLoggedIn)
        
        // Then
        #expect(result == false)
    }
}
