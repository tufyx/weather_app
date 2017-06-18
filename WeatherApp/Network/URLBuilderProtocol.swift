//
//  URLBuilderProtocol.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation

protocol URLBuilderProtocol {
    
    func urlFor(endpoint: String) -> String
    
}
