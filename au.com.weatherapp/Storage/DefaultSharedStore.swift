//
//  DefaultSharedStore.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 28/4/21.
//

import Foundation


class DefaultSharedStore: Store {
    private let userDefaults: UserDefaults = UserDefaults.standard
    
    func isValid(forKey key: StorageKey) -> Bool {
        return key.accessControl == .SharedDefault
    }
    
    func set(value: Data, forKey key: StorageKey) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    func get(forKey key: StorageKey) -> Data? {
        return userDefaults.data(forKey: key.rawValue)
    }
    
    func remove(forKey key: StorageKey) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
    
    func removeAll() {
       userDefaults.dictionaryRepresentation().forEach {
            userDefaults.removeObject(forKey: $0.key)
        }
    }
}
