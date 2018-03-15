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
    
    func didTapCellWith(data: CityListItemViewModel)
    
}

class CityCell: UITableViewCell, ReusableProtocol {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var delegate: CityCellClickDelegate?
    
    var data: CityListItemViewModel? {
        didSet {
            nameLabel.text = "Unknown City"
            temperatureLabel.text = "N/A"
            if let d = data {
                nameLabel.text = d.name
                temperatureLabel.text = "\(d.temperature)°C"
            }
            
            
            contentView.addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector(didTapCell)
                )
            )
        }
    }
    
    @objc func didTapCell() {
        if let d = data {
            delegate?.didTapCellWith(data: d)
            return
        }
        
        print("No info in this cell!")
    }
    
}
