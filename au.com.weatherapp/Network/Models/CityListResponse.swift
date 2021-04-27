//
//  CityListResponse.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 27/4/21.
//

import Foundation

struct CityListResponse: Codable {
    let id: Int?
    let name: String?
    let coord: Coordinate?
    let country: String?
}
