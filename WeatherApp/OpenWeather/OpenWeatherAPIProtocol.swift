//
//  OpenWeatherAPIProtocol.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import Alamofire

protocol OpenWeatherAPIProtocol {
    
    var delegate: OpenWeatherAPIDelegate? { get set }
    
    func weatherForCity(city: String, inCountry: String)
    
}

protocol OpenWeatherAPIDelegate: class, BaseProtocol {
    
    func didReceiveData(response: Any?)
    
}

class OpenWeatherAPIService: OpenWeatherAPIProtocol {
    
    let networkService: NetworkProtocol
    
    weak var delegate: OpenWeatherAPIDelegate?
    
    init(service: NetworkProtocol) {
        self.networkService = service
    }
    
    func weatherForCity(city: String, inCountry country: String) {
        let request = APIRequest(
            endpoint: .Weather,
            bodyParams: [
                "q": "\(city),\(country)",
                "appId": "dc3ab2fad7af61db48b6fa9acaad7369"
            ]
        )
        
        networkService.request(apiRequest: request, delegate: delegate, errorHandler: NetworkService.DefaultErrorClosure, successHandler: { (response) in
            self.delegate?.didReceiveData(response: response.value)
        })
    }
    
}
