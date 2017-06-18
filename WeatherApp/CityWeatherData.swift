//
//  CityWeatherData.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import SwiftyJSON

class CityWeatherData: JSONProtocol {
    
    var weatherConditions: [WeatherCondition]
    let temperature: String?
    let humidty: Float?
    let pressure: Float?
    let minTemperature: String?
    let maxTemperature: String?
    
    let name: String
    
    let visibilty: Float
    
    required init(json: JSON) {
        
        temperature = json["main"].dictionary?["temp"]?.stringValue
        minTemperature = json["main"].dictionary?["temp_min"]?.stringValue
        maxTemperature = json["main"].dictionary?["temp_max"]?.stringValue
        humidty = json["main"].dictionary?["humidity"]?.floatValue
        pressure = json["main"].dictionary?["pressure"]?.floatValue
        visibilty = json["visibility"].floatValue
        
        name = json["name"].stringValue
        
        weatherConditions = []
        let wc = json["weather"].arrayValue
        wc.forEach { (json) in
            weatherConditions.append(WeatherCondition(json: json))
        }
    }
 
    static let Unknown = CityWeatherData(json: JSON(["name": "Unknown"]))
    
}
