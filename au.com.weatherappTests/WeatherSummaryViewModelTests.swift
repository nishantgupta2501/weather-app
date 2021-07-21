//
//  WeatherSummaryViewModelTests.swift
//  au.com.weatherappTests
//
//  Created by Nishant Gupta on 21/7/21.
//

import XCTest
@testable import au_com_weatherapp

private let networkManager = MockNetworkManager()
private let storeProvider = MockStoreProvider()

class WeatherSummaryViewModelTests: XCTestCase {
    override class func setUp() {
        Network.register(networkManager)
        StorageAPI.register(storeProvider)
    }
    
    override class func tearDown() {
        Network.deRegister()
        StorageAPI.deRegister()
    }

    func testSuccess() {
        networkManager.isSuccess = true
        networkManager.errorType = nil
        let viewModel = WeatherSummaryViewModel()
        viewModel.callWeatherAPI()
        XCTAssertEqual(viewModel.weatherInfo.count, 1)
        XCTAssertFalse(viewModel.weatherInfo[0].isLoading)
        XCTAssert(viewModel.weatherInfo[0].cityName == "Sydney")
        XCTAssert(viewModel.weatherInfo[0].temperature == 6.5)
    }
    
    func testErrorScenario() {
        networkManager.isSuccess = false
        networkManager.errorType = .invalidData
        let viewModel = WeatherSummaryViewModel()
        viewModel.callWeatherAPI()
        XCTAssertEqual(viewModel.weatherInfo.count, 1)
        XCTAssertFalse(viewModel.weatherInfo[0].isLoading)
        XCTAssertEqual(viewModel.weatherInfo[0].cityName, "")
        XCTAssertNil(viewModel.weatherInfo[0].temperature)
    }
    
    func testWhenNoCityIDReturnedFromStorage() {
        storeProvider.cityIds = nil
        networkManager.isApiCalled = false
        let viewModel = WeatherSummaryViewModel()
        viewModel.callWeatherAPI()
        XCTAssertEqual(viewModel.weatherInfo.count, 0)
        XCTAssertFalse(networkManager.isApiCalled)
    }

}
