//
//  Network.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 21/7/21.
//

import Foundation

struct Network {
    private static var networkManager: NetworkManager?
    
    static func register(_ networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    static func deRegister() {
        self.networkManager = nil
    }
    
    static func fetch<T: Codable>(for url:URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        self.networkManager?.fetch(for: url, completion: completion)
    }
}
