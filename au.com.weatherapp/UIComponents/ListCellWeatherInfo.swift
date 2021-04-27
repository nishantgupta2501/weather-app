//
//  ListCellWeatherInfo.swift
//  au.com.weatherapp
//
//  Created by Nishant K Gupta on 26/4/21.
//

import UIKit


class ListCellWeatherInfo: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    static let cellId = "ListCellWeatherInfoIdentifier"
    
    private let activityIndicator = UIActivityIndicatorView()
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func bind(cityName: String, temperature: Double?, isLoading: Bool) {
        cityNameLabel.text = cityName
        if isLoading {
            activityIndicator.frame = self.temperatureLabel.bounds
            self.temperatureLabel.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        }
        else {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            if let temperature = temperature {
                temperatureLabel.text = "\(temperature)C"
            }
            else {
                temperatureLabel.text = "Not Available"
            }
        }
    }
    
}
