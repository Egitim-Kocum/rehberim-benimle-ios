//
//  KeychainManagerTests.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Testing
@testable import RehberimBenimle

@Suite("KeychainManager Tests")
struct KeychainManagerTests {
    
    var sut: MockKeychainManager!
    
    private struct Token: Codable, Equatable {
        let value: String
    }
    
    init() {
        sut = MockKeychainManager()
    }
    
    @Test("Save and retrieve codable item")
    func testSaveAndRetrieve() throws {
        let token = Token(value: "1234")
        
        try sut.save(token, forKey: .authToken)
        let result: Token = try sut.retrieve(forKey: .authToken, as: Token.self)
        
        #expect(result == token)
        
        sut.clearAll()
    }
    
    @Test("Delete removes item")
    func testDeleteItem() throws {
        try sut.save(Token(value: "x"), forKey: .refreshToken)
        try sut.delete(forKey: .refreshToken)
        
        #expect(!sut.exists(forKey: .refreshToken))
    }
}
