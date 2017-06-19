//
//  OpenWeatherUserDefaults.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import SwiftyJSON

class OWUserDefaultsCity {
    
    var googleId: String
    var owId: String
    
    init(googleId: String, owId: String) {
        self.googleId = googleId
        self.owId = owId
    }
    
    init(dictionary: [String: String]) {
        self.googleId = dictionary["googleId"]!
        self.owId = dictionary["owId"]!
    }
    
    var json: [String: String] {
        return [
            "googleId": googleId,
            "owId": owId
        ]
    }
    
}

protocol OWUserDefaultsProtocol {
    
    @discardableResult func save(city: OWUserDefaultsCity) -> [OWUserDefaultsCity]
    
    func fetchList() -> [OWUserDefaultsCity]
    
    func getGoogleIdFor(owId: String) -> String?
    
}

class OWUserDefaults: OWUserDefaultsProtocol {

    let defaults: UserDefaults
    
    init() {
        self.defaults = UserDefaults.standard
    }
    
    @discardableResult func save(city: OWUserDefaultsCity) -> [OWUserDefaultsCity] {
        var cities = defaults.array(forKey: "cities")
        
        if cities == nil {
            cities = []
        }
        
        cities!.append(city.json)
        defaults.setValue(cities!, forKey: "cities")
        defaults.synchronize()
        
        return fetchList()
    }
    
    func getGoogleIdFor(owId: String) -> String? {
        let l = fetchList()
        let f = l.filter { (city) -> Bool in
            city.owId == owId
        }
        if f.count == 0 {
            return nil
        }
        
        return f[0].googleId
        
    }
    
    func fetchList() -> [OWUserDefaultsCity] {
        if let cities = defaults.array(forKey: "cities") as? [[String: String]] {
            let l = cities.map({ (element) -> OWUserDefaultsCity in
                OWUserDefaultsCity(dictionary: element)
            })
            return l
        }
        return []
    }
    
}
