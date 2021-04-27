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

    init() {
        fetchCityInfo()
    }

    private func fetchCityInfo() {
        DispatchQueue.global(qos: .userInteractive).async {
            WeatherService().fetchCityList(withfileName: "citylist") { [weak self] result in
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
