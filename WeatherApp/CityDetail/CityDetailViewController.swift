//
//  CityDetailViewController.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces

class CityDetailViewController: UIViewController, ReusableProtocol {
    
    var city: CityWeatherData?
    
    var weatherService: OpenWeatherAPIProtocol?
    
    var googlePlacesService: GMSPlacesClient?
    
    var userDefaults: OWUserDefaultsProtocol?
    
    @IBOutlet var placeImage: UIImageView!
    
    override func viewDidLoad() {
        if let c = city {
            title = c.name
            let owId = userDefaults!.getGoogleIdFor(owId: String(c.id))!
            googlePlacesService?.lookUpPhotos(forPlaceID: owId, callback: { (list, error) in
                self.googlePlacesService?.loadPlacePhoto((list?.results[0])!, callback: { (image, error) in
                    if let _ = error {
                        print("error returned for image at index 0")
                        return
                    }
                    
                    self.placeImage.image = image
                })
            })
            return
        }
        title = "Unknown"
    }
    
}
