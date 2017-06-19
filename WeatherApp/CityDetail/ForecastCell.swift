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

    var data: CityWeatherData? {
        didSet {

            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.timeStyle = .short

            let d = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(data!.timestamp)))
            timeLabel.text = "\(d)"
            conditionLabel.text = data!.weatherConditions[0].description
            temperatureLabel.text = "\(round(data!.main.temperature!.celsius))°C"
        }
    }

}
