//
//  AddCityViewController.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 27/4/21.
//

import Foundation
import UIKit
import CoreLocation

import UIKit

protocol AddCitiesDelegate {
    func reloadCities()
}

class AddCityViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredList: [CityListResponse] = [CityListResponse]()
    var cityList: [CityListResponse] = [CityListResponse]()
    var delegate: AddCitiesDelegate?
    var searchActive: Bool = false
    var viewModel = AddCityViewModel()
    var selectedCityIds: [Int] = []
    var initialSelectedCities: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        viewModel.delegate = self
        selectedCityIds = StorageAPI.string(forkey: StorageKey.storedCityIds)?.components(separatedBy: ",").map { Int($0) ?? 0 } ?? []
        initialSelectedCities = selectedCityIds.count
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed {
            StorageAPI.set(string: (selectedCityIds.map { String($0)} ).joined(separator: ","), forkey: StorageKey.storedCityIds)
            if selectedCityIds.count !=  initialSelectedCities {
                delegate?.reloadCities()
            }
        }
    }

    func setUpUI() {
        title = "Add City"
        navigationController?.isNavigationBarHidden = false
        tableView.register(UINib(nibName: String(describing: ListCellCityInfo.self),
                                 bundle: Bundle(for: ListCellCityInfo.self)),
                           forCellReuseIdentifier: ListCellCityInfo.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UISearchBarDelegate Setup
extension AddCityViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        view.endEditing(true)
        filteredList = cityList
        tableView.reloadData()
    }
    

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBarSearchBegin(searchBar)
        view.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchActive = true
    }

    func searchBarSearchBegin(_ searchBar: UISearchBar) {
        let strText: String =  searchBar.text!.replacingOccurrences(of: " ", with: "")
        if (strText ).isEmpty {
            searchActive = false
        } else {
            DispatchQueue.main.async {
                self.filteredList.removeAll()
                let foundItems = self.cityList.filter { (($0.name?.range(of: strText)) != nil) || $0.id == Int(strText) }
                self.filteredList =  foundItems
                self.searchActive = true
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate Setup

extension AddCityViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCellCityInfo.cellId, for: indexPath) as? ListCellCityInfo else {
            fatalError("AddCitiesCell not found")
        }
        cell.addCitiesModel = filteredList[indexPath.row]
        if let cityId = filteredList[indexPath.row].id {
            cell.accessoryType = selectedCityIds.contains(cityId) ? .checkmark : .none
        }
        return cell
    }
}

extension AddCityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if let cityId = filteredList[indexPath.row].id {
        if selectedCityIds.contains(cityId) {
            selectedCityIds = selectedCityIds.filter { $0 != cityId }
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            }
        else {
            selectedCityIds.append(cityId)
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

// MARK: - UISearchBarDelegate ViewModelProtocol

extension AddCityViewController : AddCityViewModelProtocol {
    func loadCityList(cityList: [CityListResponse]) {
        self.cityList = cityList
        filteredList = cityList
        tableView.reloadData()
    }
}
