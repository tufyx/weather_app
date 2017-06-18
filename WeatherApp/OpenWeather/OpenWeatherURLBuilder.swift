//
//  OpenWeatherURLBuilder.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation

class OpenWeatherURLBuilder: URLBuilderProtocol {
    
    func urlFor(endpoint: String) -> String {
        return "http://api.openweathermap.org/data/2.5/\(endpoint)"
    }
    
}
