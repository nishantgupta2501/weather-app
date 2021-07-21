//
//  WeatherDetailsViewModelTests.swift
//  au.com.weatherappTests
//
//  Created by Nishant Gupta on 22/7/21.
//

import XCTest
@testable import au_com_weatherapp

class WeatherDetailsViewModelTests: XCTestCase {
    
    func testWhenAllFieldsAreAvailable() {
        let weatherResponse = WeatherResponse(
            main: Main(
                humidity: 5,
                temp_min: -2.0,
                temp_max: 8.0,
                temp: 6.5),
            name: "Sydney",
            id: 12,
            weather: [
            Weather(description: "Chilling day")])
        let mappedWeatherData = WeatherDetailViewModel(weatherInfo: weatherResponse).mapDetailDataSource()
        XCTAssertTrue(mappedWeatherData.count == 2, "test case failed, weather info mapping didn't pass")
        XCTAssertEqual(mappedWeatherData.first?.first?.heading, "Sydney")
        XCTAssertEqual(mappedWeatherData.first?.first?.value, "Chilling day")
        XCTAssertEqual(mappedWeatherData[1].count, 3)
    }
    
    func testWhenTempDetailsNotAvailable() {
        let weatherResponse = WeatherResponse(
            main: Main(
                humidity: nil,
                temp_min: nil,
                temp_max: nil,
                temp: 6.5),
            name: "Sydney",
            id: 12,
            weather: [
            Weather(description: "Chilling day")])
        let mappedWeatherData = WeatherDetailViewModel(weatherInfo: weatherResponse).mapDetailDataSource()
        XCTAssertTrue(mappedWeatherData.count == 2, "test case failed, weather info mapping didn't pass")
        XCTAssertEqual(mappedWeatherData.first?.first?.heading, "Sydney")
        XCTAssertEqual(mappedWeatherData.first?.first?.value, "Chilling day")
        XCTAssertEqual(mappedWeatherData[1].count, 0)
    }
}
