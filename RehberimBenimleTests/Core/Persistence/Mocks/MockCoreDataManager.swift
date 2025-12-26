//
//  MockCoreDataManager.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import CoreData
@testable import RehberimBenimle

final class MockCoreDataManager: CoreDataManagerProtocol {
    var shouldThrowOnSave = false
    var shouldThrowOnFetch = false
    var shouldThrowOnDelete = false
    
    // MARK: - Tracking
    private(set) var didCallSave = false
    private(set) var didCallFetch = false
    private(set) var didCallDelete = false
    private(set) var didCallPerformBackgroundTask = false
    
    // MARK: - Fake store
    private var fakeStore: [String: [NSManagedObject]] = [:]
    
    // MARK: - Context
    var viewContext: NSManagedObjectContext {
        let container = NSPersistentContainer(name: "Mock")
        container.persistentStoreDescriptions.first?.type = NSInMemoryStoreType
        container.loadPersistentStores { _, _ in }
        return container.viewContext
    }
    
    // MARK: - CRUD
    
    func create<T: NSManagedObject>(_ type: T.Type) -> T {
        let obj = T(context: viewContext)
        let key = String(describing: type)
        fakeStore[key, default: []].append(obj)
        return obj
    }
    
    func fetch<T: NSManagedObject>(
        _ type: T.Type,
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil
    ) throws -> [T] {
        didCallFetch = true
        if shouldThrowOnFetch {
            throw CoreDataError.fetchFailed(NSError(domain: "MockError", code: 0))
        }
        let key = String(describing: type)
        return (fakeStore[key] ?? []).compactMap { $0 as? T }
    }
    
    func save() throws {
        didCallSave = true
        if shouldThrowOnSave {
            throw CoreDataError.saveFailed(NSError(domain: "MockError", code: 0))
        }
    }
    
    func delete<T: NSManagedObject>(_ object: T) throws {
        didCallDelete = true
        if shouldThrowOnDelete {
            throw CoreDataError.deleteFailed(NSError(domain: "MockError", code: 0))
        }
        let key = String(describing: T.self)
        fakeStore[key]?.removeAll { $0 == object }
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        didCallPerformBackgroundTask = true
        block(viewContext)
    }
}
