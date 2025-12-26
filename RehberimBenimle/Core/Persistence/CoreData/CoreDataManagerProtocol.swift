//
//  CoreDataManagerProtocol.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Foundation
import CoreData

enum CoreDataError: Error {
    case persistentStoreLoadFailed(Error)
    case saveFailed(Error)
    case fetchFailed(Error)
    case deleteFailed(Error)
}

protocol CoreDataManagerProtocol {
    var viewContext: NSManagedObjectContext { get }
    func save() throws
    func fetch<T: NSManagedObject>(_ type: T.Type,
                                    predicate: NSPredicate?,
                                    sortDescriptors: [NSSortDescriptor]?) throws -> [T]
    func create<T: NSManagedObject>(_ type: T.Type) -> T
    func delete<T: NSManagedObject>(_ object: T) throws
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void)
}
