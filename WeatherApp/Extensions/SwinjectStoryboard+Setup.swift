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

extension SwinjectStoryboard {
    
    class func setup() {
        Container.loggingFunction = nil
        _ = Assembler([
            NetworkAssembly()
            ], container: defaultContainer
        )
        
        assembleViewControllers()
        
    }
    
    class func assembleViewControllers() {
        defaultContainer.storyboardInitCompleted(ViewController.self) { (resolver, cnt) in
//            container.weatherService = resolver.resolve(OpenWeatherAPIProtocol.self)
        }
        
    }
}
