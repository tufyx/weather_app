//
//  CityListPresenter.swift
//  WeatherApp
//
//  Created by Tufyx on 19/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import GooglePlaces

protocol CityListViewProtocol: class {
    
    var context: UIViewController? { get }
    
    func didReceive(weatherData: [CityWeatherData])
    
}

protocol CityListPresenterProtocol: class {
    
    var view: CityListViewProtocol? { get set }
    
    func showPlaceSelectionScreen()
    
    func showCityDetailScreenFor(city: CityWeatherData)
    
    func checkLocationPermission()
    
    func loadData()

}

class CityListPresenter: NSObject, CityListPresenterProtocol {
    
    var view: CityListViewProtocol?
    
    var interactor: CityListInteractorProtocol
    
    var router: CityListRouterProtocol
    
    init(interactor: CityListInteractorProtocol, router: CityListRouterProtocol) {
        self.interactor = interactor
        self.router = router
        super.init()
        
        self.interactor.result = self
    }
    
    func showPlaceSelectionScreen() {
        router.routeToPlaceSelectionScreen(fromContext: view?.context, withDelegate: self)
    }
    
    func showCityDetailScreenFor(city: CityWeatherData) {
        router.routeToCityDetailScreenFor(city: city, fromContext: view?.context)
    }
    
    func checkLocationPermission() {
        interactor.checkLocationPermission()
    }
    
    func loadData() {
        interactor.loadData()
    }
    
}

extension CityListPresenter: CityListInteractorResultProtocol {
    
    func didFetch(data: [CityWeatherData]) {
        view?.didReceive(weatherData: data)
    }
    
}

extension CityListPresenter: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        interactor.fetchWeatherDataFor(place: place)
        view?.context?.dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        view?.context?.dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
