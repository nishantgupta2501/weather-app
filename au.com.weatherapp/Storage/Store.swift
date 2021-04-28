//
//  BackingStore.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 28/4/21.
//

import Foundation

protocol Store {
    func isValid(forKey key: StorageKey) -> Bool
    func set(value: Data, forKey key: StorageKey)
    func get(forKey key: StorageKey) -> Data?
    func remove(forKey key: StorageKey)
    func removeAll()
}
