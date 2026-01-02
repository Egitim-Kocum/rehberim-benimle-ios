//
//  CoreDataManagerTests.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import CoreData
import Testing
@testable import RehberimBenimleCoreKit

//
//@Suite("CoreDataManager Tests")
//@MainActor
//struct CoreDataManagerTests {
//    let storage = MockCoreDataManager()
//    
//    @Test("Should be able to save data")
//    func test_CoreDataManager_save_shouldSucceed() throws {
//        // Given
//        storage.shouldThrowError = false
//        
//        // When & Then
//        try storage.save()
//    }
//    
//    @Test("Should not be able to save data if throws error")
//    func test_CoreDataManager_save_shouldThrowError() {
//        // Given
//        storage.shouldThrowError = true
//        
//        // When & Then
//        #expect(throws: CoreDataError.self) {
//            try storage.save()
//        }
//    }
//    
//    @Test("Should be able to create a new NSManagedObject")
//    func test_CoreDataManager_create_shouldReturnObject() {
//        // When
//        let object = storage.create(NSManagedObject.self)
//        
//        // Then
//        #expect(object.managedObjectContext != nil)
//    }
//    
//    @Test("Should fetch an empty array")
//    func test_CoreDataManager_fetch_shouldReturnEmptyArray() throws {
//        // Given
//        storage.shouldThrowError = false
//        
//        // When
//        let results = try storage.fetch(NSManagedObject.self, predicate: nil, sortBy: nil)
//        
//        // Then
//        #expect(results.isEmpty)
//    }
//    
//    @Test("Should throw an error when fetching")
//    func test_CoreDataManager_fetch_shouldThrowError() {
//        // Given
//        storage.shouldThrowError = true
//        
//        // When & Then
//        #expect(throws: CoreDataError.self) {
//            _ = try storage.fetch(NSManagedObject.self, predicate: nil, sortBy: nil)
//        }
//    }
//    
//    @Test("Should be able to delete an object")
//    func test_CoreDataManager_delete_shouldSucceed() throws {
//        // Given
//        storage.shouldThrowError = false
//        let object = storage.create(NSManagedObject.self)
//        
//        // When & Then
//        try storage.delete(object)
//    }
//    
//    @Test("Should throw an error when deleting")
//    func test_CoreDataManager_delete_shouldThrowError() {
//        // Given
//        storage.shouldThrowError = true
//        let object = storage.create(NSManagedObject.self)
//        
//        // When & Then
//        #expect(throws: CoreDataError.self) {
//            try storage.delete(object)
//        }
//    }
//    
//    @Test("Should be able to delete all objects")
//    func test_CoreDataManager_deleteAll_shouldSucceed() throws {
//        // Given
//        storage.shouldThrowError = false
//        
//        // When & Then
//        try storage.deleteAll(NSManagedObject.self)
//    }
//    
//    @Test("Should throw an error when deleting all objects")
//    func test_CoreDataManager_deleteAll_shouldThrowError() {
//        // Given
//        storage.shouldThrowError = true
//        
//        // When & Then
//        #expect(throws: CoreDataError.self) {
//            try storage.deleteAll(NSManagedObject.self)
//        }
//    }
//    
//    @Test("Should execute a block in the background")
//    func test_CoreDataManager_performBackground_shouldExecuteBlock() async {
//        // When
//        await withCheckedContinuation { continuation in
//            storage.performBackground { _ in
//                continuation.resume()
//            }
//        }
//        
//        // Then
//        #expect(true)
//    }
//}
