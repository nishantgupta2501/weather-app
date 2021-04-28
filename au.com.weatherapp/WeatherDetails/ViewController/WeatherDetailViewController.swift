//
//  WeatherDetailViewController.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 28/4/21.
//

import UIKit


class WeatherDetailViewController: UIViewController {
    var detailViewModel: WeatherDetailViewModel?
    private var detailDataSource: [[WeatherDetailModel]]?
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
        detailDataSource = detailViewModel?.mapDetailDataSource() ?? []
    }
}

extension WeatherDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        detailDataSource?[section].count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherDetailCell.cellId, for: indexPath) as! WeatherDetailCell
        cell.bind(model: detailDataSource?[indexPath.section][indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        detailDataSource?.count ?? 0
    }

}
