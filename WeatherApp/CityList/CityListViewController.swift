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

class CityListViewController: UITableViewController {
    
    @IBOutlet weak var addCityButton: UIBarButtonItem!
    
    var cities: [CityWeatherData] = []
    
    var weatherService: OpenWeatherAPIProtocol?
    var placesClient: GMSPlacesClient?
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        weatherService?.delegate = self
        checkLocationPermissionFor(manager: locationManager)
        addCityButton.target = self
        addCityButton.action = #selector(didLaunchPlaceFinder)
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cities.count == 0 {
            showEmptyResult()
        } else {
            tableView.backgroundView = UIView()
        }
        
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CityCell.self)
        cell.data = cities[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cities[indexPath.row]
        print("did select >> \(city.name)")
    }
    
    func showEmptyResult() {
        let emptyStateView = EmptyStateView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        emptyStateView.emptyTitle = "No cities were found"
        emptyStateView.emptySubtitle = "Tap the button at the top-right corner to search for a location and add it in the list"
        emptyStateView.image = UIImage(named: "umbrella")
        tableView.backgroundView = emptyStateView
        emptyStateView.center = tableView.center
    }
    
}

extension CityListViewController: OpenWeatherAPIDelegate {
    
    func didReceiveDataFor(city: CityWeatherData) {
        if cities.has(obj: city) {
            return
        }
        
        cities.append(city)
        tableView.reloadData()
    }
    
    func didReceive(error: NSError) {
        print("did receive open weather error")
    }
    
}

extension CityListViewController: GMSAutocompleteViewControllerDelegate {
    
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
