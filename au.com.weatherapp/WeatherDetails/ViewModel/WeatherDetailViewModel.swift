//
//  WeatherDetailViewModel.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 28/4/21.
//

import Foundation


class WeatherDetailViewModel {
    private let weatherInfo: WeatherResponse
    
    init (weatherInfo: WeatherResponse) {
        self.weatherInfo = weatherInfo
    }
    
    func mapDetailDataSource() -> [[WeatherDetailModel]] {
        var dataSource: [[WeatherDetailModel]] = []
        if let cityName = weatherInfo.name {
            dataSource.append([WeatherDetailModel(heading: cityName,
                                                  value: weatherInfo.weather?.first?.description ?? "")])
        }
        var temperatureDetails = [WeatherDetailModel]()
        if let minTemp = weatherInfo.main?.temp_min {
            temperatureDetails.append(WeatherDetailModel(heading: "Minimum temperature",
                                                         value: "\(minTemp) °C"))
        }
        
        if let maxTemp = weatherInfo.main?.temp_max {
            temperatureDetails.append(WeatherDetailModel(heading: "Maximum temperature",
                                                         value: "\(maxTemp) °C"))
        }
        if let humidity = weatherInfo.main?.humidity {
            temperatureDetails.append(WeatherDetailModel(heading: "Humidity",
                                                         value: String(humidity)))
        }
        
        dataSource.append(temperatureDetails)
        return dataSource
    }
}
