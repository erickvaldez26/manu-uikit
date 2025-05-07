//
//  StorageService.swift
//  manu
//
//  Created by Erick Valdez on 6/05/25.
//

import Foundation

final class UserDefaultsStorage: StorageService {
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    func set<T>(_ value: T, for key: any StorageKey) throws where T : Decodable, T : Encodable {
        let data = try JSONEncoder().encode(value)
        defaults.set(data, forKey: key.rawValue)
    }
    
    func get<T>(_ key: any StorageKey, as type: T.Type) throws -> T? where T : Decodable, T : Encodable {
        guard let data = defaults.data(forKey: key.rawValue) else { return nil }
        return try JSONDecoder().decode(type, from: data)
    }
    
    func remove(_ key: any StorageKey) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    func clearAll() {
        guard let appDomain = Bundle.main.bundleIdentifier else { return }
        defaults.removePersistentDomain(forName: appDomain)
        defaults.synchronize()
    }
}
