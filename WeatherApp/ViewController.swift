//
//  ViewController.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard
import GooglePlaces

class ViewController: UIViewController {
    
    @IBOutlet weak var findPlaceButton: UIButton!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    var weatherService: OpenWeatherAPIProtocol?
    var placesClient: GMSPlacesClient?
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherService?.delegate = self
        checkLocationPermissionFor(manager: locationManager)
        findPlaceButton.addTarget(self, action: #selector(didLaunchPlaceFinder), for: .touchUpInside)
    }
    
    func didLaunchPlaceFinder() {
        let vc = GMSAutocompleteViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    
    func checkLocationPermissionFor(manager: CLLocationManager?) {
        if manager == nil {
            return
        }
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            manager?.requestWhenInUseAuthorization()
        }
        
    }

}

extension ViewController: OpenWeatherAPIDelegate {
    
    func didReceiveDataFor(city: CityWeatherData) {
        print("did receive open weather data for \(city.name)")
        print(city)
    }
    
    func didReceive(error: NSError) {
        print("did receive open weather error")
    }
    
}

extension ViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        weatherService?.weatherForCity(city: place.name)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
