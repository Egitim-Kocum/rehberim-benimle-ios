//
//  CoreDataManager.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Foundation
import CoreData

final class CoreDataManager: CoreDataManagerProtocol {
    
    static let shared = CoreDataManager()
    private let container: NSPersistentContainer
    
    init(container: NSPersistentContainer? = nil) {
        if let container = container {
            self.container = container
        } else {
            let defaultContainer = NSPersistentContainer(name: "RehberimBenimle")
            defaultContainer.loadPersistentStores { _, error in
                if let error = error {
                    fatalError("⚠️ Core Data failed to load: \(error.localizedDescription)")
                }
            }
            self.container = defaultContainer
        }
    }
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save() throws {
        let context = viewContext
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            throw CoreDataError.saveFailed(error)
        }
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        container.performBackgroundTask(block)
    }
    
    func create<T: NSManagedObject>(_ type: T.Type) -> T {
        return T(context: viewContext)
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type,
                                    predicate: NSPredicate? = nil,
                                    sortDescriptors: [NSSortDescriptor]? = nil) throws -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: type))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        do {
            return try viewContext.fetch(request)
        } catch {
            throw CoreDataError.fetchFailed(error)
        }
    }
    
    func delete<T: NSManagedObject>(_ object: T) throws {
        viewContext.delete(object)
        do {
            try save()
        } catch {
            throw CoreDataError.deleteFailed(error)
        }
    }
}
