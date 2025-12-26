//
//  CoreDataManagerTests.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import CoreData
import Testing
@testable import RehberimBenimle

/*
@Suite("CoreDataManager Tests")
struct CoreDataManagerTests {
    var sut: CoreDataManager!
    var mockContainer: NSPersistentContainer!
    
    init() {
        // In-memory
        mockContainer = NSPersistentContainer(name: "RehberimBenimle")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        mockContainer.persistentStoreDescriptions = [description]
        
        mockContainer.loadPersistentStores { _, error in
            if let error {
                #error("Failed to load in-memory store:")
            }
        }
        
        sut = CoreDataManager(container: mockContainer)
    }
    
    @Test("Create and Save should persist entity")
    func testCreateAndSave() throws {
        let person = sut.create(Person.self)
        person.name = "Okan"
        person.phoneNumber = "12345689"
        
        try sut.save()
        
        let fetched = try sut.fetch(Person.self)
        
        #expect(fetched.count == 1)
        #expect(fetched.first?.name = "Okan")
        #expect(fetched.first?.phoneNumber = "12345689")
    }
    
    @Test("Fetch with predicate should filter results")
     func fetchWithPredicate() throws {
         let p1 = sut.create(Person.self)
         p1.name = "Ali"
         let p2 = sut.create(Person.self)
         p2.name = "Okan"
         try sut.save()
         
         let predicate = NSPredicate(format: "name == %@", "Okan")
         let result = try sut.fetch(Person.self, predicate: predicate)
         
         #expect(result.count == 1)
         #expect(result.first?.name == "Okan")
     }
     
     @Test("Delete should remove entity from context")
     func deleteEntity() throws {
         let p = sut.create(Person.self)
         p.name = "ToDelete"
         try sut.save()
         
         try sut.delete(p)
         
         let all = try sut.fetch(Person.self)
         #expect(all.isEmpty)
     }
}
*/
