//
//  CityDetailAssembly.swift
//  WeatherApp
//
//  Created by Vlad Tufis on 19/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import Swinject
import GooglePlaces

class CityDetailAssembly: Assembly {

    func assemble(container: Container) {

        container.register(CityDetailPresenterProtocol.self) { (resolver) -> CityDetailPresenterProtocol in
            CityDetailPresenter(
                interactor: resolver.resolve(CityDetailInteractorProtocol.self)!,
                router: resolver.resolve(CityDetailRouterProtocol.self)!
            )
        }

        container.register(CityDetailInteractorProtocol.self) { (resolver) -> CityDetailInteractorProtocol in
            CityDetailInteractor(
                service: resolver.resolve(OpenWeatherAPIProtocol.self)!,
                gpService: resolver.resolve(GMSPlacesClient.self)!,
                userDefaults: resolver.resolve(OWUserDefaultsProtocol.self)!
            )
        }

        container.register(CityDetailRouterProtocol.self) { (resolver) -> CityDetailRouterProtocol in
            CityDetailRouter()
        }

    }

}
