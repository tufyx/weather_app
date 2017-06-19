//
//  CityDetailViewController.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces

class CityDetailViewController: UIViewController, ReusableProtocol {
    
    var city: CityWeatherData?

    var presenter: CityDetailPresenterProtocol?
    
    @IBOutlet var placeImage: UIImageView!
    
    override func viewDidLoad() {

        presenter?.city = city
        presenter?.view = self

        if let c = city {
            title = c.name
            presenter?.fetchImageForPlace()
            return
        }
        
        title = "Unknown"
    }
    
}

extension CityDetailViewController: CityDetailViewProtocol {

    var context: UIViewController {
        return self
    }

    func didReceiveForecast() {
        print("did receive forecast")
    }

    func didReceiveError() {
        print("did receive error")
    }

    func didFetchPlaceImage(image: UIImage?) {
        placeImage.image = image!
    }

    func didGetErrorForImage() {
        print("error when fetching image for place")
    }

}
