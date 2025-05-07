//
//  StorageKeys.swift
//  manu
//
//  Created by Erick Valdez on 6/05/25.
//

protocol StorageKey {
    var rawValue: String { get }
}

enum AppStorageKey: String, StorageKey {
    case obfuscationBalance
}
