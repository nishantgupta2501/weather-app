//
//  ListCellCityInfo.swift
//  au.com.weatherapp
//
//  Created by Nishant Gupta on 27/4/21.
//

import UIKit

class ListCellCityInfo: UITableViewCell {
    @IBOutlet weak var labelCityName: UILabel!
    public static let cellId = "ListCellCityInfoIdentifier"
    
    public var addCitiesModel: CityListResponse? {
        didSet {
            guard let data = addCitiesModel else {
                return
            }
            labelCityName.text = data.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
