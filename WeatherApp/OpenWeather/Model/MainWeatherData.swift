//
//  MainWeatherData.swift
//  WeatherApp
//
//  Created by Vlad Tufis on 19/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import SwiftyJSON

class MainWeatherData: JSONProtocol {

    let temperature: Float?

    let minTemperature: Float?

    let maxTemperature: Float?

    let humidty: Float?

    let pressure: Float?

    required init(json: JSON) {

        temperature = json["temp"].floatValue

        minTemperature = json["temp_min"].floatValue

        maxTemperature = json["temp_max"].floatValue

        humidty = json["humidity"].floatValue

        pressure = json["pressure"].floatValue
        
    }

}
