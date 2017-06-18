//
//  NetworkProtocol.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import Alamofire

typealias ErrorClosure = (Result<Any>, BaseProtocol?) -> Void
typealias SuccessClosure = (Result<Any>) -> Void

protocol NetworkProtocol {
    
    func request(
        apiRequest: APIRequest,
        delegate: BaseProtocol?,
        errorHandler: @escaping ErrorClosure,
        successHandler: @escaping SuccessClosure
    )
}
