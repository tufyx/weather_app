//
//  FloatExtension.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation

extension Float {
    
    var celsius: Float {
        return self - 273.15
    }
    
    var fahrenheit: Float {
        return self * 9/5 - 459.67
    }
    
}
