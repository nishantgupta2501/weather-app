//
//  WeatherSummaryViewModel.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 26/4/21.
//

import Foundation

protocol WeatherSummaryViewModelProtocol: AnyObject {
    func refreshWeatherData(for row: Int)
}

class WeatherSummaryViewModel {
    var weatherInfo: [CityWeatherInfo]
    weak var delegate: WeatherSummaryViewModelProtocol?
    private var cities = ["4163971": "Sydney",
                          "2147714": "Melbourne",
                          "2174003": "Brisbane"]
    
    init() {
        weatherInfo = cities.map {
            CityWeatherInfo(cityID: $0.key, cityName: $0.value, temperature: nil, isLoading: true)
        }

    }
    
    func callWeatherAPI() {
        weatherInfo.forEach { weather in
            WeatherService().getWeatherByCity(cityId: weather.cityID) { [weak self] result in
                guard let self = self,
                    let row = self.weatherInfo.firstIndex(where: {$0.cityID == weather.cityID})
                    else { return }
                switch(result) {
                case let .success(weatherResponse) :
                    self.weatherInfo[row].isLoading = false
                    self.weatherInfo[row].temperature = weatherResponse.weather.temperature
                    DispatchQueue.main.async {
                        self.delegate?.refreshWeatherData(for: row)
                    }
                case .failure(_):
                    self.weatherInfo[row].isLoading = false
                }
                
            }
        }
    }
}

struct CityWeatherInfo {
    let cityID: String
    let cityName: String
    var temperature: Double?
    var isLoading: Bool
}
