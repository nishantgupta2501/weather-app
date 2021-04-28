//
//  BackingStore.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 28/4/21.
//

import Foundation

protocol Store {
    /// Method to check if particular store can be used for a key
    /// - Parameter key: Key for Data to be stored/ retreived
    func isValid(forKey key: StorageKey) -> Bool
    
    /// Method to set store data into store based on key
    /// - Parameters:
    ///   - value: value to be stored
    ///   - key: key  associated with data
    func set(value: Data, forKey key: StorageKey)
    
    
    /// Method to retrieve data
    /// - Parameter key: key associated with data
    func get(forKey key: StorageKey) -> Data?
    
    
    /// Method to remove data based on key
    /// - Parameter key: key associated with data
    func remove(forKey key: StorageKey)
    
    
    /// Method ro remove all data from store
    func removeAll()
}
