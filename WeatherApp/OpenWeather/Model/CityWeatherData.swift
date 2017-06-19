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

    let timestamp: Float
    
    let name: String

    let main: MainWeatherData

    let wind: WindData

    let visibilty: Float
    
    var weatherConditions: [WeatherCondition]
    
    required init(json: JSON) {
        
        id = json["id"].intValue

        timestamp = json["dt"].floatValue

        name = json["name"].stringValue

        main = MainWeatherData(json: JSON(json["main"].dictionaryValue))

        wind = WindData(json: JSON(json["wind"].dictionaryValue))
        
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
