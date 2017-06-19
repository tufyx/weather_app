//
//  AppAssembly.swift
//  WeatherApp
//
//  Created by Tufyx on 20/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import Swinject

class AppAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(OWUserDefaultsProtocol.self) { (_) -> OWUserDefaultsProtocol in
            return OWUserDefaults()
        }
        
    }
    
}
