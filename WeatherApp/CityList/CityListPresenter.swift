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
    
    func didReceiveData()
    
}

protocol CityListPresenterProtocol: class {
    
    var view: CityListViewProtocol? { get set }
    
    func showPlaceSelectionScreen()
    
    func showCityDetailScreenFor(city: CityListItemViewModel)
    
    func checkLocationPermission()
    
    func loadData()
    
    func getList() -> [CityListItemViewModel]

}

class CityListPresenter: NSObject, CityListPresenterProtocol {
    
    var view: CityListViewProtocol?
    
    var interactor: CityListInteractorProtocol
    
    var router: CityListRouterProtocol
    
    var list: [CityListItemViewModel]
    
    init(interactor: CityListInteractorProtocol, router: CityListRouterProtocol) {
        self.interactor = interactor
        self.router = router
        self.list = []
        super.init()
        
        self.interactor.result = self
    }
    
    func showPlaceSelectionScreen() {
        router.routeToPlaceSelectionScreen(fromContext: view?.context, withDelegate: self)
    }
    
    func showCityDetailScreenFor(city: CityListItemViewModel) {
        router.routeToCityDetailScreenFor(city: city, fromContext: view?.context)
    }
    
    func checkLocationPermission() {
        interactor.checkLocationPermission()
    }
    
    func loadData() {
        interactor.loadData()
    }
    
    func getList() -> [CityListItemViewModel] {
        return list
    }
    
}

extension CityListPresenter: CityListInteractorResultProtocol {
    
    func didFetch(data: [CityWeatherData]) {
        list = data.cityListVM
        view?.didReceiveData()
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
