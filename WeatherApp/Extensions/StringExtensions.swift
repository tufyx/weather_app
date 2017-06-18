//
//  StringExtensions.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation


extension String {
    
    func formattedWith(params: [String]) -> String {
        return String(format: self, arguments: params.map { $0 as CVarArg })
    }
    
}
