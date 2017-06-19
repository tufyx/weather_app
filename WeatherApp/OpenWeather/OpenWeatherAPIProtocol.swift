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
    
    var delegate: OpenWeatherAPIDelegate? { get set }
    
    func weatherForCity(city: String)
    
    func weatherForList(cityList: [String])
    
    func forecastForCity(cityId: String)
    
}

protocol OpenWeatherAPIDelegate: class, BaseProtocol {
    
    func didReceiveDataFor(city: CityWeatherData)
    
    func didReceiveDataFor(cities: [CityWeatherData])
    
}

class OpenWeatherAPIService: OpenWeatherAPIProtocol {
    
    let networkService: NetworkProtocol
    let keyProvider: APIKeyProvider
    
    weak var delegate: OpenWeatherAPIDelegate?
    
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
        
        
        networkService.request(apiRequest: request, delegate: delegate, errorHandler: NetworkService.DefaultErrorClosure, successHandler: { (response) in
            if let value = response.value {
                self.delegate?.didReceiveDataFor(city: CityWeatherData(json: JSON(value)))
                return
            }
            
            self.delegate?.didReceiveDataFor(city: CityWeatherData.Unknown)
            
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
        
        
        networkService.request(apiRequest: request, delegate: delegate, errorHandler: NetworkService.DefaultErrorClosure, successHandler: { (response) in
            if let value = response.value {
                self.delegate?.didReceiveDataFor(cities: JsonParser.parseJson(JSON(value)))
                return
            }
            
            self.delegate?.didReceiveDataFor(city: CityWeatherData.Unknown)
            
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
        
        
        networkService.request(apiRequest: request, delegate: delegate, errorHandler: NetworkService.DefaultErrorClosure, successHandler: { (response) in
            if let value = response.value {
                self.delegate?.didReceiveDataFor(cities: JsonParser.parseJson(JSON(value)))
                return
            }
            
            self.delegate?.didReceiveDataFor(city: CityWeatherData.Unknown)
            
        })
    }
    
}
