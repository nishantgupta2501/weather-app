//
//  URL+Extensions.swift
//  au.com.weatherapp
//
//  Created by Nishant K Gupta on 26/4/21.
//

import Foundation

extension URL {
    static let baseURLString = "https://api.openweathermap.org/data/2.5/"
    static func weatherDetailsUrl(cityId: String) -> URL? {
        return URL(string: "\(baseURLString)weather?id=\(cityId)&appid=\(API.key)")
    }
}
