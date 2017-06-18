//
//  NetworkAssembly.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import Swinject

class NetworkAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(URLBuilderProtocol.self) { (_) -> URLBuilderProtocol in
            return OpenWeatherURLBuilder()
        }
        
        container.register(NetworkProtocol.self) { (resolver) -> NetworkProtocol in
            return NetworkService(builder: resolver.resolve(URLBuilderProtocol.self)!)
        }
        
        container.register(OpenWeatherAPIProtocol.self) { (resolver) -> OpenWeatherAPIProtocol in
            return OpenWeatherAPIService(service: resolver.resolve(NetworkProtocol.self)!)
        }
    }
    
}
