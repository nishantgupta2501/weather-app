//
//  WeatherSummaryTableViewController.swift
//  au.com.weatherapp
//
//  Created by Nishant K Gupta on 26/4/21.
//

import UIKit


class WeatherSummaryTableViewController: UITableViewController {
    private let viewModel = WeatherSummaryViewModel()
    private var mainStoryBoard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle(for: WeatherSummaryTableViewController.self))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupNavigationBar()
        
        tableView.register(UINib(nibName: String(describing: ListCellWeatherInfo.self),
                                 bundle: Bundle(for: ListCellWeatherInfo.self)),
                           forCellReuseIdentifier: ListCellWeatherInfo.cellId)
        tableView.reloadData()
        tableView.delegate = self
        tableView.becomeFirstResponder()
        viewModel.delegate = self
        viewModel.callWeatherAPI()
    }
    
    private func SetupNavigationBar() {
        title = "Weather Summary"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add City", style: .plain, target: self, action: #selector(launchAddCityController))
    }
    
    @objc private func launchAddCityController()
    {
        guard let addCityViewController = mainStoryBoard.instantiateViewController(withIdentifier: "AddCity") as? AddCityViewController
        else { return }
        navigationController?.present(addCityViewController, animated: true, completion: nil)
    }
}


extension WeatherSummaryTableViewController {
    
    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.weatherInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCellWeatherInfo.cellId)
                            as? ListCellWeatherInfo
                            ?? ListCellWeatherInfo(style: .default, reuseIdentifier: ListCellWeatherInfo.cellId)
        let weatherInfo = viewModel.weatherInfo[indexPath.row]
        cell.bind(cityName: weatherInfo.cityName, temperature: weatherInfo.temperature, isLoading: weatherInfo.isLoading)
        return cell
    }

    override func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let bpayBiller = filteredBpayList?[indexPath.row] else { return }
//        delegate?.didSelectAtRow(bpayBiller: bpayBiller)
    }
}

extension WeatherSummaryTableViewController: WeatherSummaryViewModelProtocol {
    func refreshWeatherData(for row: Int) {
        let indexPath = IndexPath(item: row, section: 0)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
