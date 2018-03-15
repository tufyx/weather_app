//
//  CityPhotoInteractor.swift
//  WeatherApp
//
//  Created by Vlad Tufis on 15/03/2018.
//  Copyright © 2018 tufyx. All rights reserved.
//

import Foundation

protocol CityPhotoInteractorResultProtocol: class {

	// DEFINE INTERACTOR RESULT BEHAVIOUR HERE
	
}

protocol CityPhotoInteractorProtocol: class {

	weak var result: CityPhotoInteractorResultProtocol? { get set }

	// DEFINE INTERACTOR BEHAVIOUR HERE
	
}

class CityPhotoInteractor: CityPhotoInteractorProtocol {
	
	weak var result: CityPhotoInteractorResultProtocol?

	// IMPLEMENT INTERACTOR BEHAVIOUR HERE

}
