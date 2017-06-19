//
//  APIEndpoint.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import Alamofire

enum URLEndpoint: String {
    
    case Weather = "weather"
    case Forecast = "forecast"
    case Group = "group"
    
}

class ApiEndpoint {
    
    let url: URLEndpoint
    let method: HTTPMethod
    
    init(url: URLEndpoint, method: HTTPMethod) {
        self.url = url
        self.method = method
    }
    
    static let Weather = ApiEndpoint(url: .Weather, method: .get)
    static let Forecast = ApiEndpoint(url: .Forecast, method: .get)
    static let Group = ApiEndpoint(url: .Group, method: .get)
    
}
