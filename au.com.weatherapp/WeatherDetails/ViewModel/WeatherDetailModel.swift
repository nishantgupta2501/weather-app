//
//  WeatherDetailModel.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 28/4/21.
//

import Foundation


struct WeatherDetailModel {
    let heading: String
    let value: String
    
    init(heading: String, value: String) {
        self.heading = heading
        self.value = value
    }
}
