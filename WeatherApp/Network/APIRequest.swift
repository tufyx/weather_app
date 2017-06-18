//
//  APIRequest.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import Alamofire

class APIRequest {
    
    let method: HTTPMethod
    let endpoint: String
    let encoding: ParameterEncoding
    
    var parameters: Parameters?
    var headers: HTTPHeaders?
    
    required init(
        endpoint: ApiEndpoint,
        bodyParams: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        encoding: ParameterEncoding = URLEncoding.default
        ) {
        self.method = endpoint.method
        self.endpoint = endpoint.url.rawValue
        self.parameters = bodyParams
        self.headers = headers
        self.encoding = encoding
    }
    
    func set(headers: HTTPHeaders) {
        self.headers = headers
    }
    
}
