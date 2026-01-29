//
//  CoreDataManager.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Foundation
import CoreData

@MainActor
public final class CoreDataManager: CoreDataManagerProtocol {
    
    public static let shared = CoreDataManager()
    
    private let container: NSPersistentContainer
    
    public var context: NSManagedObjectContext {
        container.viewContext
    }
    
    public init(modelName: String = "RehberimBenimle") {
        container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData yüklenemedi: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    public init(inMemory: Bool) {
        container = NSPersistentContainer(name: "RehberimBenimle")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData yüklenemedi: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    public func save() throws {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            throw CoreDataError.saveFailed
        }
    }
    
    public func create<T: NSManagedObject>(_ type: T.Type) -> T {
        return T(context: context)
    }
    
    public func fetch<T: NSManagedObject>(
        _ type: T.Type,
        predicate: NSPredicate? = nil,
        sortBy: [NSSortDescriptor]? = nil
    ) throws -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        request.predicate = predicate
        request.sortDescriptors = sortBy
        
        do {
            return try context.fetch(request)
        } catch {
            throw CoreDataError.fetchFailed
        }
    }
    
    public func delete<T: NSManagedObject>(_ object: T) throws {
        context.delete(object)
        try save()
    }
    
    public func deleteAll<T: NSManagedObject>(_ type: T.Type) throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: type))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try save()
        } catch {
            throw CoreDataError.deleteFailed
        }
    }
    
    public func performBackground(_ block: @escaping @Sendable (NSManagedObjectContext) -> Void) {
        container.performBackgroundTask(block)
    }
}
