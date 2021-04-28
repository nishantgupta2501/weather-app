//
//  WeatherResponse.swift
//  au.com.weatherapp
//
//  Created by Nishant K Gupta on 26/4/21.
//

import Foundation

struct WeatherResponse: Codable {
    var main: Main?
    var name: String?
    var id: Int?
    var coord: Coordinate?
    var weather: [Weather]?
    var clouds: Clouds?
    var dt: Int?
    var base: String?
    var sys: Sys?
    var cod: Int?
    var visibility: Int?
    var wind: Wind?
}
