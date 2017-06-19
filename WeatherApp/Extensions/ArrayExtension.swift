//
//  ArrayExtension.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation

extension Array {
    
    func has<T>(obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
    
}

extension Array where Element: OWUserDefaultsCity {
    func owIDs() -> [String] {
        return self.map({ (element) -> String in
            element.owId
        })
    }
}
