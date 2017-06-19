//
//  CityDetailInteractor.swift
//  WeatherApp
//
//  Created by Vlad Tufis on 19/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import GooglePlaces

protocol CityDetailInteractorResultProtocol: class {

    func didReceive(forecast: [CityWeatherData])

    func didReceiveError()

    func didFetchPlaceImage(image: UIImage?)

    func didGetErrorForImage()

}

protocol CityDetailInteractorProtocol {

    weak var result: CityDetailInteractorResultProtocol? { get set }

    func fetchForecastFor(city: String)

    func fetchGoogleImageForPlace(id: String)

}

class CityDetailInteractor: CityDetailInteractorProtocol {

    weak var result: CityDetailInteractorResultProtocol?

    var service: OpenWeatherAPIProtocol

    var gpService: GMSPlacesClient

    var userDefaults: OWUserDefaultsProtocol

    init(service: OpenWeatherAPIProtocol, gpService: GMSPlacesClient, userDefaults: OWUserDefaultsProtocol) {
        self.service = service
        self.gpService = gpService
        self.userDefaults = userDefaults

        self.service.forecastDelegate = self
    }

    func fetchGoogleImageForPlace(id: String) {
        if let placeId = userDefaults.getGoogleIdFor(owId: id) {
            gpService.lookUpPhotos(forPlaceID: placeId) { (list, error) in
                if list == nil {
                    self.result?.didGetErrorForImage()
                }

                if list!.results.count == 0 {
                    self.result?.didGetErrorForImage()
                    return
                }

                self.gpService.loadPlacePhoto(list!.results[0], callback: { (image, errorImage) in
                    if let _ = errorImage {
                        self.result?.didGetErrorForImage()
                        return
                    }

                    self.result?.didFetchPlaceImage(image: image)
                })
            }
            return
        }

        result?.didGetErrorForImage()
    }

    func fetchForecastFor(city: String) {
        service.forecastForCity(cityId: city)
    }
}

extension CityDetailInteractor: OWAPIForecastDelegate {

    func didReceive(forecast: [CityWeatherData]) {
        result?.didReceive(forecast: forecast)
    }

    func didReceive(error: NSError) {
        print("did receive error for forecast")
        result?.didReceiveError()
    }

}
