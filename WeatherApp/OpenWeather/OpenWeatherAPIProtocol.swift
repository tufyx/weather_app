//
//  OpenWeatherAPIProtocol.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol OpenWeatherAPIProtocol {
    
    weak var weatherDelegate: OWAPIWeatherDelegate? { get set }

    weak var forecastDelegate: OWAPIForecastDelegate? { get set }
    
    func weatherForCity(city: String)
    
    func weatherForList(cityList: [String])
    
    func forecastForCity(cityId: String)
    
}

protocol OWAPIWeatherDelegate: class, BaseProtocol {
    
    func didReceiveDataFor(city: CityWeatherData)
    
    func didReceiveDataFor(cities: [CityWeatherData])
    
}

protocol OWAPIForecastDelegate: class, BaseProtocol {

    func didReceive(forecast: [CityWeatherData])

}

class OpenWeatherAPIService: OpenWeatherAPIProtocol {

    weak var weatherDelegate: OWAPIWeatherDelegate?

    weak var forecastDelegate: OWAPIForecastDelegate?

    let networkService: NetworkProtocol
    let keyProvider: APIKeyProvider
    
    init(service: NetworkProtocol, keyProvider: APIKeyProvider) {
        self.networkService = service
        self.keyProvider = keyProvider
    }
    
    func weatherForCity(city: String) {
        let request = APIRequest(
            endpoint: .Weather,
            bodyParams: [
                "q": "\(city)",
                "appId": keyProvider.provideAPIKey()
            ]
        )
        
        
        networkService.request(apiRequest: request, delegate: weatherDelegate, errorHandler: NetworkService.DefaultErrorClosure, successHandler: { (response) in
            if let value = response.value {
                self.weatherDelegate?.didReceiveDataFor(city: CityWeatherData(json: JSON(value)))
                return
            }
            
            self.weatherDelegate?.didReceiveDataFor(city: CityWeatherData.Unknown)
            
        })
    }
    
    func weatherForList(cityList: [String]) {
        let request = APIRequest(
            endpoint: .Group,
            bodyParams: [
                "id": "\(cityList.joined(separator: ","))",
                "appId": keyProvider.provideAPIKey()
            ]
        )
        
        
        networkService.request(apiRequest: request, delegate: weatherDelegate, errorHandler: NetworkService.DefaultErrorClosure, successHandler: { (response) in
            if let value = response.value {
                self.weatherDelegate?.didReceiveDataFor(cities: JsonParser.parseJson(JSON(value)))
                return
            }
            
            self.weatherDelegate?.didReceiveDataFor(city: CityWeatherData.Unknown)
            
        })
    }
    
    func forecastForCity(cityId: String) {
        let request = APIRequest(
            endpoint: .Forecast,
            bodyParams: [
                "id": "\(cityId)",
                "appId": keyProvider.provideAPIKey()
            ]
        )
        
        
        networkService.request(apiRequest: request, delegate: forecastDelegate, errorHandler: NetworkService.DefaultErrorClosure, successHandler: { (response) in
            if let value = response.value {
                self.forecastDelegate?.didReceive(forecast: JsonParser.parseJson(JSON(value)))
                return
            }
            
            self.forecastDelegate?.didReceive(forecast: [])
            
        })
    }
    
}
