//
//  Sys.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 28/4/21.
//

import Foundation

struct Sys: Codable {
    var sunset: Int?
    var sunrise: Int?
    var message: Double?
    var id: Int?
    var type: Int?
    var country: String?
}
