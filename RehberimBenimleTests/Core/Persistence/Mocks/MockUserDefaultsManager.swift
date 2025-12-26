//
//  MockUserDefaultsManager.swift
//  RehberimBenimle
//
//  Created by Okan Orkun on 12.10.2025.
//

import Foundation
@testable import RehberimBenimle

final class MockUserDefaultsManager: UserDefaultsManagerProtocol {
    var defaults: UserDefaults
    
    init() {
        let suiteName = "MockUserDefaults_\(UUID().uuidString)"
        self.defaults = UserDefaults(suiteName: suiteName)!
        self.defaults.removePersistentDomain(forName: suiteName)

    }
    
    func save<T>(_ value: T, forKey key: UserDefaultsKeys) throws where T : Codable {
        let data = try JSONEncoder().encode(value)
        defaults.set(data, forKey: key.rawValue)
    }
    
    func retrieve<T>(forKey key: UserDefaultsKeys, as type: T.Type) throws -> T? where T: Codable {
        guard let data = defaults.data(forKey: key.rawValue) else {
            return nil
        }
        return try JSONDecoder().decode(T.self, from: data)
    }

    func delete(forKey key: UserDefaultsKeys) {
        defaults.removeObject(forKey: key.rawValue)
    }

    func exists(forKey key: UserDefaultsKeys) -> Bool {
        defaults.object(forKey: key.rawValue) != nil
    }
}
