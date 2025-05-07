//
//  StorageServiceProtocol.swift
//  manu
//
//  Created by Erick Valdez on 6/05/25.
//

protocol StorageService {
    func set<T: Codable>(_ value: T, for key: StorageKey) throws
    func get<T: Codable>(_ key: StorageKey, as type: T.Type) throws -> T?
    func remove(_ key: StorageKey)
    func clearAll()
}
