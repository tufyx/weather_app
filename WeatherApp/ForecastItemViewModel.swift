//
//  ForecastItemViewModel.swift
//  WeatherApp
//
//  Created by Tufyx on 20/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation

class ForecastItemViewModel {
    
    
    var temperature: Float
    var minTemperature: Float
    var maxTemperature: Float
    var humidty: Float
    var pressure: Float
    var weatherCondition: String
    var icon: String
    
    var formattedDate: String
    
    init(model: CityWeatherData) {
        
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
        
        self.weatherCondition = "-"
        self.icon = "-"
        let wc = model.weatherConditions[0]
        
        self.weatherCondition = wc.description!
        self.icon = "http://openweathermap.org/img/w/\(wc.icon! ).png"
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        self.formattedDate = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(model.timestamp)))
    }
    
}
