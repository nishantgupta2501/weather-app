//
//  StorageAPI.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 28/4/21.
//

import Foundation

class StorageAPI {
    static let storeProvider: StoreProvider = StoreProviderImplementation()
    
    static func set(string value: String, forkey key: StorageKey) {
        StorageAPI.storeProvider.set(value: Data(value.utf8), forKey: key)
    }
    
    static func set(data value: Data, forkey key: StorageKey) {
        StorageAPI.storeProvider.set(value: value, forKey: key)
    }
    
    static func string(forkey key: StorageKey) -> String? {
        guard let data = StorageAPI.storeProvider.get(forKey: key) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    static func get(forkey key: StorageKey) -> Data? {
        return storeProvider.get(forKey: key)
    }
}
