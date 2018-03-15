//
//  CityListRouter.swift
//  WeatherApp
//
//  Created by Tufyx on 19/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import GooglePlaces

protocol CityListRouterProtocol {
 
    func routeToPlaceSelectionScreen(fromContext context: UIViewController?, withDelegate delegate: GMSAutocompleteViewControllerDelegate)
    
    func routeToCityDetailScreenFor(city: CityListItemViewModel, fromContext context: UIViewController?)
    
}

class CityListRouter: CityListRouterProtocol {
    
    let detailStoryboard: UIStoryboard
    
    init() {
        detailStoryboard = UIStoryboard(name: "Main", bundle: nil)
    }
    
    func routeToPlaceSelectionScreen(fromContext context: UIViewController?, withDelegate delegate: GMSAutocompleteViewControllerDelegate) {
        let vc = GMSAutocompleteViewController()
        
        
        vc.delegate = delegate
        context?.present(vc, animated: true, completion: nil)
    }
    
    func routeToCityDetailScreenFor(city: CityListItemViewModel, fromContext context: UIViewController?) {
        let vc = detailStoryboard.instantiateViewController(ofType: CityDetailViewController.self)
        vc.city = city
        context?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
