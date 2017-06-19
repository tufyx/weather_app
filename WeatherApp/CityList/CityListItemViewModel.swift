//
//  CityListViewModel.swift
//  WeatherApp
//
//  Created by Tufyx on 20/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation

class CityListItemViewModel {
    
    let id: Int
    let name: String
    var temperature: Float
    var minTemperature: Float
    var maxTemperature: Float
    var humidty: Float
    var pressure: Float
    
    init(model: CityWeatherData) {
        self.id = model.id
        self.name = model.name
        
        self.temperature = 0
        if let t = model.main.temperature {
            self.temperature = round(t.celsius)
        }
        
        self.minTemperature = 0
        if let t = model.main.minTemperature {
            self.minTemperature = round(t.celsius)
        }
        
        self.maxTemperature = 0
        if let t = model.main.maxTemperature {
            self.maxTemperature = round(t.celsius)
        }
        
        self.humidty = 0
        if let h = model.main.humidty {
            self.humidty = h
        }
        
        self.pressure = 0
        if let p = model.main.pressure {
            self.pressure = p
        }
        
    }
    
}
