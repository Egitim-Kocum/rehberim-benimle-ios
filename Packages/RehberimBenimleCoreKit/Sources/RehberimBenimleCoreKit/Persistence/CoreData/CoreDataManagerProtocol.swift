//
//  CoreDataManagerProtocol.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Foundation
import CoreData

public enum CoreDataError: Error {
    case saveFailed
    case fetchFailed
    case deleteFailed
}

@MainActor
public protocol CoreDataManagerProtocol: Sendable {
    var context: NSManagedObjectContext { get }
    func save() throws
    func create<T: NSManagedObject>(_ type: T.Type) -> T
    func fetch<T: NSManagedObject>(_ type: T.Type, predicate: NSPredicate?, sortBy: [NSSortDescriptor]?) throws -> [T]
    func delete<T: NSManagedObject>(_ object: T) throws
    func deleteAll<T: NSManagedObject>(_ type: T.Type) throws
    func performBackground(_ block: @escaping @Sendable (NSManagedObjectContext) -> Void)
}
