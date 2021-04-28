//
//  StorageAPI.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 28/4/21.
//

import Foundation


/// API to interact with device storage
class StorageAPI {
    static let storeProvider: StoreProvider = StoreProviderImplementation()
    
    
    /// Method to Store string into a store
    /// - Parameters:
    ///   - value: value to be stored
    ///   - key: key associated with data
    static func set(string value: String, forkey key: StorageKey) {
        StorageAPI.storeProvider.set(value: Data(value.utf8), forKey: key)
    }
    
    
    /// Method to Store Data into a store
    /// - Parameters:
    ///   - value: value to be stored
    ///   - key: key associated with data
    static func set(data value: Data, forkey key: StorageKey) {
        StorageAPI.storeProvider.set(value: value, forKey: key)
    }
    
    
    /// Method to retrieve string value from storage based on key
    /// - Parameter key: Key associated with data
    /// - Returns: String value stored
    static func string(forkey key: StorageKey) -> String? {
        guard let data = StorageAPI.storeProvider.get(forKey: key) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
    /// Method to retrieve data value from storage based on key
    /// - Parameter key: Key associated with data
    /// - Returns: Data value stored
    static func get(forkey key: StorageKey) -> Data? {
        return storeProvider.get(forKey: key)
    }
}
