//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Vlad Tufis on 19/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import UIKit

class ForecastCell: UITableViewCell, ReusableProtocol {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionIcon: UIImageView!

    var data: ForecastItemViewModel? {
        didSet {
            
            timeLabel.text = "N/A"
            conditionLabel.text = "N/A"
            temperatureLabel.text = "N/A"
            conditionIcon.image = UIImage(named: "sad_cloud")
            
            if let d = data {
                timeLabel.text = d.formattedDate
                conditionLabel.text = d.weatherCondition
                temperatureLabel.text = "\(d.temperature)°C"
                conditionIcon.downloadedFrom(link: d.icon)
            }
        }
    }

}
