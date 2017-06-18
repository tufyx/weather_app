//
//  CityCell.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import UIKit

class CityCell: UITableViewCell, ReusableProtocol {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var data: CityWeatherData? {
        didSet {
            nameLabel.text = data?.name
            
            temperatureLabel.text = "N/A"
            if let t = data?.temperature {
                temperatureLabel.text = "\(round(t.celsius))°C"
            }
            
        }
    }
    
    
    
}
