//
//  MockCoreDataManager.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import CoreData
import Foundation
@testable import RehberimBenimleCoreKit

// MARK: - MockCoreDataManager
@MainActor
final class MockCoreDataManager: CoreDataManagerProtocol {
    var context: NSManagedObjectContext {
        let container = NSPersistentContainer(name: "Test")
        return container.viewContext
    }
    
    var shouldThrowError = false
    var savedObjects: [NSManagedObject] = []
    
    func save() throws {
        if shouldThrowError {
            throw CoreDataError.saveFailed
        }
    }
    
    func create<T: NSManagedObject>(_ type: T.Type) -> T {
        return T(context: context)
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type, predicate: NSPredicate?, sortBy: [NSSortDescriptor]?) throws -> [T] {
        if shouldThrowError {
            throw CoreDataError.fetchFailed
        }
        return []
    }
    
    func delete<T: NSManagedObject>(_ object: T) throws {
        if shouldThrowError {
            throw CoreDataError.deleteFailed
        }
        savedObjects.removeAll { $0 == object }
    }
    
    func deleteAll<T: NSManagedObject>(_ type: T.Type) throws {
        if shouldThrowError {
            throw CoreDataError.deleteFailed
        }
        savedObjects.removeAll()
    }
    
    func performBackground(_ block: @escaping @Sendable (NSManagedObjectContext) -> Void) {
        block(context)
    }
}
