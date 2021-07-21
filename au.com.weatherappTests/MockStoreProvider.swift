//
//  MockStoreProvider.swift
//  au.com.weatherappTests
//
//  Created by Nishant Gupta on 21/7/21.
//

import Foundation
@testable import au_com_weatherapp

class MockStoreProvider: StoreProvider {
    var cityIds: String? = "123456"
    
    func set(value: Data, forKey key: StorageKey) {
        cityIds = String(decoding: value, as: UTF8.self)
    }
    
    func get(forKey key: StorageKey) -> Data? {
        return cityIds?.data(using: .utf8)
    }
    
    func remove(forKey key: StorageKey) {
        cityIds = nil
    }
    
    func removeAll() {
        cityIds = nil
    }
}
