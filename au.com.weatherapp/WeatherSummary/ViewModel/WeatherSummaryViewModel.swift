//
//  WeatherSummaryViewModel.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 26/4/21.
//

import Foundation

protocol WeatherSummaryViewModelDelegate: AnyObject {
    func refreshWeatherData(for row: Int)
    func reloadWeatherData()
}

class WeatherSummaryViewModel {
    var weatherInfo: [CityWeatherInfo] = []
    weak var delegate: WeatherSummaryViewModelDelegate?
    private var cityIds: [String] = []
    private var periodicTimer: Timer!
    private let timePeriod = 60
    private let weatherService: WeatherService
    
    init() {
        weatherService = WeatherService()
        periodicTimer = Timer.scheduledTimer(timeInterval: TimeInterval(timePeriod), target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
        loadCities()
    }
    
    @objc private func runTimedCode(_ sender: AnyObject) {
        weatherInfo.indices.forEach {
            weatherInfo[$0].isLoading = true
        }
        self.callWeatherAPI()
        delegate?.reloadWeatherData()
    }
    
    func loadCities() {
        cityIds = StorageAPI.string(forkey: StorageKey.storedCityIds)?.components(separatedBy: ",") ?? []
        weatherInfo = cityIds.map {
            CityWeatherInfo(cityID: $0, cityName: "", temperature: nil, isLoading: true)
        }
    }
    
    func callWeatherAPI() {
        weatherInfo.forEach { weather in
            weatherService.getWeatherByCity(cityId: weather.cityID) { [weak self] result in
                guard let self = self,
                    let row = self.weatherInfo.firstIndex(where: {$0.cityID == weather.cityID})
                    else { return }
                switch(result) {
                case let .success(weatherResponse) :
                    self.weatherInfo[row].isLoading = false
                    self.weatherInfo[row].temperature = weatherResponse.main?.temp
                    self.weatherInfo[row].cityName = weatherResponse.name ?? ""
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
    var cityName: String
    var temperature: Double?
    var isLoading: Bool
}

// MARK: - Extensions

extension StorageKey {
    static let storedCityIds = StorageKey(rawValue: "cityIds", accessControl: .SharedDefault)
}
