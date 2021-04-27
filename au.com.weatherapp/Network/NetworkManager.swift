//
//  NetworkManager.swift
//  au.com.weatherapp
//
//  Created by Nishant K Gupta on 26/4/21.
//

import Foundation


final class NetworkManager<T: Codable> {
    static func fetch(for url:URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print(String(describing: error))
                completion(.failure(.error(err: error!.localizedDescription)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
            else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            if let jsonResponse = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(jsonResponse))
            }
            else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}


enum NetworkError: Error {
    case badUrl
    case invalidResponse
    case invalidData
    case decodingError
    case error(err: String)
}
