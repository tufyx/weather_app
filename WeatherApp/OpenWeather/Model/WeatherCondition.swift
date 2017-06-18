//
//  WeatherCondition.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherCondition {
    
    let id: Int?
    
    let main: String?
    
    let description: String?
    
    let icon: String?
    
    required init(json: JSON) {
        
        id = json["id"].intValue
        
        main = json["main"].stringValue
        
        description = json["description"].stringValue
        
        icon = json["icon"].stringValue
        
    }
    
}
