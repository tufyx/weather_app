//
//  ReusableProtocol.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation

protocol ReusableProtocol {
    
    static var reuseIdentifier: String { get }
    
}

extension ReusableProtocol {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
