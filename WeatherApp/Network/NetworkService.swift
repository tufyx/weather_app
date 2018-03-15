//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import Alamofire

/**
 Performs a non-authenticated network call to the supplied endpoint
 The URL which is being queried is formed by appending the supplied
 endpoint to the URL returned by the URLBuilderProtocol
 */

class NetworkService: NetworkProtocol {
    
    let builder: URLBuilderProtocol
    
    init(builder: URLBuilderProtocol) {
        self.builder = builder
    }
    
    func request(
        apiRequest: APIRequest,
        delegate: BaseProtocol?,
        errorHandler: @escaping ErrorClosure = NetworkService.DefaultErrorClosure,
        successHandler: @escaping SuccessClosure
        ) {
        let url = builder.urlFor(endpoint: apiRequest.endpoint)
        print("request to >> \(url)")
        Alamofire
            .request(
                url,
                method: apiRequest.method,
                parameters: apiRequest.parameters,
                encoding: apiRequest.encoding,
                headers: apiRequest.headers
            ).responseJSON(completionHandler: { (response) in
                if response.result.isFailure {
                    print("error for >> \(url)")
                    errorHandler(response.result.error!, delegate)
                    return
                }
                print("success for >> \(url)")
                successHandler(response.result)
            }
        )
    }
    
}

extension NetworkService {
    static var DefaultErrorClosure: ErrorClosure = { error, delegate in
        delegate?.didReceive(error: error)
    }
}
