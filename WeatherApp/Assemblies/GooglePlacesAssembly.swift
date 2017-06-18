//
//  GooglePlacesAssembly.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import Swinject
import GooglePlaces

class GooglePlacesAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(GMSPlacesClient.self) { (_) -> GMSPlacesClient in
            GMSPlacesClient.provideAPIKey("AIzaSyAl59H_Z_3pJfj9brMKoOYfNELwt01yMe4")
            return GMSPlacesClient.shared()
        }
        
        container.register(CLLocationManager.self) { (_) -> CLLocationManager in
            return CLLocationManager()
        }
    }
    
}
