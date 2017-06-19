//
//  CityListAssembly.swift
//  WeatherApp
//
//  Created by Tufyx on 19/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import Swinject
import GooglePlaces

class CityListAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(CityListPresenterProtocol.self) { (resolver) -> CityListPresenterProtocol in
            CityListPresenter(
                interactor: resolver.resolve(CityListInteractorProtocol.self)!,
                router: resolver.resolve(CityListRouterProtocol.self)!
            )
        }
        
        container.register(CityListInteractorProtocol.self) { (resolver) -> CityListInteractorProtocol in
            CityListInteractor(
                service: resolver.resolve(OpenWeatherAPIProtocol.self)!,
                userDefaults: resolver.resolve(OWUserDefaultsProtocol.self)!,
                manager: resolver.resolve(CLLocationManager.self)!
            )
        }
        
        container.register(CityListRouterProtocol.self) { (resolver) -> CityListRouterProtocol in
            CityListRouter()
        }
        
    }
    
}
