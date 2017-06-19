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
            AppAssembly(),
            GooglePlacesAssembly(),
            CityListAssembly(),
            CityDetailAssembly(),
            ], container: defaultContainer
        )
        
        assembleViewControllers()
        
    }
    
    class func assembleViewControllers() {
        defaultContainer.storyboardInitCompleted(CityListViewController.self) { (resolver, container) in
            container.presenter = resolver.resolve(CityListPresenterProtocol.self)
        }
        
        defaultContainer.storyboardInitCompleted(CityDetailViewController.self) { (resolver, container) in
            container.presenter = resolver.resolve(CityDetailPresenterProtocol.self)
        }
        
    }
}
