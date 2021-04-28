//
//  AddCityViewModel.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 27/4/21.
//

import Foundation

protocol AddCityViewModelProtocol: AnyObject {
    func loadCityList(cityList: [CityListResponse])
}

class AddCityViewModel {
    weak var delegate: AddCityViewModelProtocol?
    private let weatherService: WeatherService
    
    init() {
        weatherService = WeatherService()
        fetchCityInfo()
    }

    // MARK: - private methods
    private func fetchCityInfo() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.weatherService.fetchCityList(withfileName: "citylist") { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case let .success(list) :
                        self?.delegate?.loadCityList(cityList: list)
                        break
                    case .failure( _) :
                        break
                    }
                }
            }
        }
    }
}
