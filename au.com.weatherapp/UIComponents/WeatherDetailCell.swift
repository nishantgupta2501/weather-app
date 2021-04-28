//
//  WeatherDetailCell.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 28/4/21.
//

import UIKit


class WeatherDetailCell: UICollectionViewCell {
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    public static let cellId = "WeatherDetailCellIdentifier"
    
    func bind(model: WeatherDetailModel?) {
        headingLabel.text = model?.heading ?? ""
        detailLabel.text = model?.value ?? ""
    }
}
