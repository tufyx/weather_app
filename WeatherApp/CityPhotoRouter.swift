//
//  CityPhotoRouter.swift
//  WeatherApp
//
//  Created by Vlad Tufis on 15/03/2018.
//  Copyright © 2018 tufyx. All rights reserved.
//

import Foundation
import UIKit

protocol CityPhotoRouterProtocol {
	
	// DEFINE ROUTER BEHAVIOUR HERE

}

class CityPhotoRouter: CityPhotoRouterProtocol {
	
	let storyboard: UIStoryboard

	init() {
		storyboard = UIStoryboard(name: "Main", bundle: nil)
	}

	// IMPLEMENT ROUTER BEHAVIOUR HERE

}
