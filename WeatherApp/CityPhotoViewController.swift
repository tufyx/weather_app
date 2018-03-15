//
//  CityPhotoViewController.swift
//  WeatherApp
//
//  Created by Vlad Tufis on 15/03/2018.
//  Copyright © 2018 tufyx. All rights reserved.
//

import Foundation
import UIKit

class CityPhotoViewController: UIViewController {
	
	var presenter: CityPhotoPresenterProtocol?

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

	func setup() {
		presenter?.view = self
	}

}

extension CityPhotoViewController: CityPhotoViewProtocol {
	
	// IMPLEMENT VIEW BEHAVIOUR HERE
	
}