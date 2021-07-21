//
//  WeatherService.swift
//  au.com.weatherapp
//
//  Created by Nishant K Gupta on 26/4/21.
//

import Foundation

class WeatherService {
    
    func getWeatherByCity(cityId: String, completion: @escaping ((Result<WeatherResponse, NetworkError>) -> Void)) {
        guard let weatherUrl = URL.weatherDetailsUrl(cityId: cityId) else {
            completion(.failure(.badUrl))
            return
        }
        Network.fetch(for: weatherUrl, completion: completion)
    }
    
    func fetchCityList(withfileName fileName: String, completion: @escaping ((Result<[CityListResponse], NetworkError>) -> Void)) {
        
        let cityResource = FileManagerResource<[CityListResponse]>(fileName: fileName) { data in
            let cityListResponse = try? JSONDecoder().decode([CityListResponse].self, from: data)
            return cityListResponse
        }
        FileManager.load(resource: cityResource) { response in
            if let result = response {
                completion(.success(result))
            } else {
                completion(.failure(NetworkError.decodingError))
            }
        }
        
    }
}
