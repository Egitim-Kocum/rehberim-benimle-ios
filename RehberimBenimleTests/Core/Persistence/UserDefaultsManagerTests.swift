//
//  UserDefaultsManagerTests.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Testing
@testable import RehberimBenimle

@Suite("UserDefaultsManager Tests")
struct UserDefaultsManagerTests {
    var sut: MockUserDefaultsManager!
    
    private struct User: Codable, Equatable {
        let name: String
    }

    init() {
        sut = MockUserDefaultsManager()
    }
    
    @Test("Save and retrieve Codable value")
    func testSaveRetrieve() async throws {
        let user = User(name: "Okan")
        
        try sut.save(user, forKey: .isLoggedIn)
        let retrieved = try sut.retrieve(forKey: .isLoggedIn, as: User.self)
        
        #expect(retrieved == user)
    }
    
    @Test("Delete removes the key")
    func testDelete() async throws {
        try sut.save(User(name: "A"), forKey: .hasOnboardingSeen)
        sut.delete(forKey: .hasOnboardingSeen)
        
        #expect(!sut.exists(forKey: .hasOnboardingSeen))
    }
}
