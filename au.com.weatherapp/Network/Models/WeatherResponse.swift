//
//  WeatherResponse.swift
//  au.com.weatherapp
//
//  Created by Nishant K Gupta on 26/4/21.
//

import Foundation

struct WeatherResponse: Codable {
    let name: String
    var weather: Weather
    var icon: [WeatherIcon] = []
    
    private enum CodingKeys: String, CodingKey {
        case name
        case weather = "main"
        case icon = "weather"
    }
    
    enum WeatherKeys: String, CodingKey {
        case temperature = "temp"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        icon = try container.decode([WeatherIcon].self, forKey: .icon)
        let weatherContainer = try container.nestedContainer(keyedBy: WeatherKeys.self, forKey: .weather)
        let temperature = try weatherContainer.decode(Double.self, forKey: .temperature)
        weather = Weather(city: name, temperature: temperature, icon: icon.first?.icon ?? "")
    }
}

struct Weather: Codable {
    let city:  String
    let temperature: Double
    let icon: String
}

struct WeatherIcon: Codable {
    let main: String
    let description: String
    let icon: String
}
