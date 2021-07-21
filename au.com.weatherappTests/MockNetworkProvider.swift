//
//  MockNetworkProvider.swift
//  au.com.weatherappTests
//
//  Created by Nishant Gupta on 21/7/21.
//

import Foundation
@testable import au_com_weatherapp

class MockNetworkManager: NetworkManager {
    var isSuccess: Bool = true
    var errorType: NetworkError?
    var isApiCalled: Bool = false
    
    
    func fetch<T>(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        isApiCalled = true
        guard isSuccess
        else {
            completion(.failure( errorType ?? .invalidData))
            return
        }
        completion(.success(WeatherResponse(
                    main: Main(
                        humidity: 5,
                        temp_min: -2.0,
                        temp_max: 8.0,
                        temp: 6.5),
                    name: "Sydney",
                    id: 12) as! T))
    }
}
