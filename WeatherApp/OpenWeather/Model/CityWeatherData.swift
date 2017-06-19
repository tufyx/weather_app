//
//  CityWeatherData.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import SwiftyJSON

class CityWeatherData: JSONProtocol, Equatable {
    
    let id: Int
    
    let name: String
    
    let temperature: Float?
    
    let humidty: Float?
    
    let pressure: Float?
    
    let minTemperature: Float?
    
    let maxTemperature: Float?
    
    let visibilty: Float
    
    var weatherConditions: [WeatherCondition]
    
    required init(json: JSON) {
        
        id = json["id"].intValue
        
        name = json["name"].stringValue
        
        temperature = json["main"].dictionary?["temp"]?.floatValue
        
        minTemperature = json["main"].dictionary?["temp_min"]?.floatValue
        
        maxTemperature = json["main"].dictionary?["temp_max"]?.floatValue
        
        humidty = json["main"].dictionary?["humidity"]?.floatValue
        
        pressure = json["main"].dictionary?["pressure"]?.floatValue
        
        visibilty = json["visibility"].floatValue
        
        weatherConditions = []
        let wc = json["weather"].arrayValue
        wc.forEach { (json) in
            weatherConditions.append(WeatherCondition(json: json))
        }
    }
 
    static let Unknown = CityWeatherData(json: JSON(["name": "Unknown"]))
    
    static func == (lhs: CityWeatherData, rhs: CityWeatherData) -> Bool {
        return lhs.id == rhs.id
    }
    
}
