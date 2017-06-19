//
//  CityCell.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import UIKit

protocol CityCellClickDelegate {
    
    func didTapCellWith(data: CityWeatherData)
    
}

class CityCell: UITableViewCell, ReusableProtocol {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var delegate: CityCellClickDelegate?
    
    var data: CityWeatherData? {
        didSet {
            nameLabel.text = data?.name
            
            temperatureLabel.text = "N/A"
            
            if let t = data?.temperature {
                temperatureLabel.text = "\(round(t.celsius))°C"
            }
            
            contentView.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector(didTapCell)
                )
            )
        }
    }
    
    func didTapCell() {
        if let d = data {
            delegate?.didTapCellWith(data: d)
            return
        }
        
        print("No info in this cell!")
    }
    
}
