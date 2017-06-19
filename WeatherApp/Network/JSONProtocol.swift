//
//  JSONProtocol.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONProtocol {
    
    init(json: JSON)
    
}

class JsonParser {
    
    static func parseJson<T>(_ json: JSON) -> [T] where T: JSONProtocol {
        return json["list"].arrayValue.map { (json) -> T in
            T(json: json)
        }
    }
    
}
