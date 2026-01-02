//
//  KeychainManagerTests.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Testing
@testable import RehberimBenimleCoreKit

@Suite("KeychainManager Tests")
struct KeychainManagerTests {
    
    let storage = MockKeychainManager()
    
    @Test("Should be able to save and retrieve a value from the keychain")
    func test_KeychainManager_save_shouldStoreValue() throws {
        // Given
        let token = "test-token-123"
        
        // When
        try storage.save(token, key: .authToken)
        let retrieved: String = try storage.get(String.self, key: .authToken)
        
        // Then
        #expect(retrieved == token)
    }
    
    @Test("Should throw an error when trying to retrieve a non-existent value from the keychain")
    func test_KeychainManager_get_shouldThrowNotFoundError() {
        // When & Then
        #expect(throws: KeychainError.self) {
            let _: String = try storage.get(String.self, key: .refreshToken)
        }
    }
    
    @Test("Should be able to delete a value from the keychain")
    func test_KeychainManager_delete_shouldRemoveValue() throws {
        // Given
        try storage.save("token", key: .authToken)
        
        // When
        try storage.delete(key: .authToken)
        
        // Then
        let exists = storage.exists(key: .authToken)
        #expect(exists == false)
    }
    
    @Test("Should be able to save and retrieve a Codable value from the keychain")
    func test_KeychainManager_save_shouldStoreCodableStruct() throws {
        // Given
        struct User: Codable, Equatable {
            let id: Int
            let name: String
        }
        let user = User(id: 1, name: "Test")
        
        // When
        try storage.save(user, key: .authToken)
        let retrieved: User = try storage.get(User.self, key: .authToken)
        
        // Then
        #expect(retrieved == user)
    }
    
    @Test("Should be able to check if a value exists in the keychain")
    func test_KeychainManager_exists_shouldReturnTrue() throws {
        // Given
        try storage.save("token", key: .authToken)
        
        // When
        let exists = storage.exists(key: .authToken)
        
        // Then
        #expect(exists == true)
    }
    
    @Test("Should be able to check if a value exists in the keychain")
    func test_KeychainManager_exists_shouldReturnFalse() {
        // When
        let exists = storage.exists(key: .refreshToken)
        
        // Then
        #expect(exists == false)
    }
}
