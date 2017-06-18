//
//  SwinjectStoryboard+Setup.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import GooglePlaces

extension SwinjectStoryboard {
    
    class func setup() {
        Container.loggingFunction = nil
        _ = Assembler([
            NetworkAssembly(),
            GooglePlacesAssembly()
            ], container: defaultContainer
        )
        
        assembleViewControllers()
        
    }
    
    class func assembleViewControllers() {
        defaultContainer.storyboardInitCompleted(CityListViewController.self) { (resolver, container) in
            container.weatherService = resolver.resolve(OpenWeatherAPIProtocol.self)
            container.placesClient = resolver.resolve(GMSPlacesClient.self)
            container.locationManager = resolver.resolve(CLLocationManager.self)
        }
        
    }
}
