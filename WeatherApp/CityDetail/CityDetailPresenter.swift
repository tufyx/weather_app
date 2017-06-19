//
//  CityDetailPresenter.swift
//  WeatherApp
//
//  Created by Vlad Tufis on 19/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import UIKit

protocol CityDetailViewProtocol {

    var context: UIViewController { get }

    func didReceiveForecast()

    func didReceiveError()

    func didGetErrorForImage()

    func didFetchPlaceImage(image: UIImage?)

}

protocol CityDetailPresenterProtocol {

    var view: CityDetailViewProtocol? { get set }

    var city: CityWeatherData? { get set }

    func fetchForecast()

    func fetchImageForPlace()

}

class CityDetailPresenter: CityDetailPresenterProtocol {

    var view: CityDetailViewProtocol?

    var city: CityWeatherData?

    var interactor: CityDetailInteractorProtocol

    let router: CityDetailRouterProtocol

    init(interactor: CityDetailInteractorProtocol, router: CityDetailRouterProtocol) {
        self.interactor = interactor
        self.router = router

        self.interactor.result = self
    }

    func fetchForecast() {
        if let c = city {
            interactor.fetchForecastFor(city: String(c.id))
        }
    }

    func fetchImageForPlace() {
        if let c = city {
            interactor.fetchGoogleImageForPlace(id: String(c.id))
        }

    }
}

extension CityDetailPresenter: CityDetailInteractorResultProtocol {

    func didReceiveForecast() {
        view?.didReceiveForecast()
    }

    func didReceiveError() {
        view?.didReceiveError()
    }

    func didGetErrorForImage() {
        view?.didGetErrorForImage()
    }

    func didFetchPlaceImage(image: UIImage?) {
        view?.didFetchPlaceImage(image: image)
    }

}
