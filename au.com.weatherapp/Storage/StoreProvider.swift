//
//  StoreProvider.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 28/4/21.
//

import Foundation

protocol StoreProvider {
    func set(value: Data, forKey key: StorageKey)
    func get(forKey key: StorageKey) -> Data?
    func remove(forKey key: StorageKey)
    func removeAll()
}


class StoreProviderImplementation: StoreProvider {
    let stores: [Store] = [DefaultSharedStore()]
    func set(value: Data, forKey key: StorageKey) {
        getStore(forKey: key)?.set(value: value, forKey: key)
    }
    
    func get(forKey key: StorageKey) -> Data? {
        getStore(forKey: key)?.get(forKey: key)
    }
    
    func remove(forKey key: StorageKey) {
        getStore(forKey: key)?.remove(forKey: key)
    }
    
    func removeAll() {
        stores.forEach {
            $0.removeAll()
        }
    }
    
    private func getStore(forKey key: StorageKey) -> Store? {
         return stores.first { $0.isValid(forKey: key) }
    }
}
