//
//  WindData.swift
//  WeatherApp
//
//  Created by Vlad Tufis on 19/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import SwiftyJSON

class WindData: JSONProtocol {

    let speed: Float

    let degree: Float

    required init(json: JSON) {

        speed = json["speed"].floatValue

        degree = json["degree"].floatValue

    }

}
