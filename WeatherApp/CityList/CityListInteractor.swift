//
//  CityListInteractor.swift
//  WeatherApp
//
//  Created by Tufyx on 19/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import CoreLocation
import GooglePlaces

protocol CityListInteractorResultProtocol {
    
    func didFetch(data: [CityWeatherData])
    
}

protocol CityListInteractorProtocol: class {
    
    var result: CityListInteractorResultProtocol? { get set }
    
    func fetchWeatherDataFor(place: GMSPlace)
    
    func fetchWeatherDataFor(list: [String])
    
    func checkLocationPermission()
    
    func loadData()
    
}

class CityListInteractor: CityListInteractorProtocol {

    var result: CityListInteractorResultProtocol?
    
    var service: OpenWeatherAPIProtocol
    let userDefaults: OWUserDefaultsProtocol
    let manager: CLLocationManager
    
    var weatherData: [CityWeatherData] = []
    var gmsPlace: GMSPlace?
    
    init(service: OpenWeatherAPIProtocol, userDefaults: OWUserDefaultsProtocol, manager: CLLocationManager) {
        self.service = service
        self.userDefaults = userDefaults
        self.manager = manager
        
        self.service.weatherDelegate = self
    }
    
    func fetchWeatherDataFor(list: [String]) {
        service.weatherForList(cityList: list)
    }
    
    func fetchWeatherDataFor(place: GMSPlace) {
        gmsPlace = place
        service.weatherForCity(city: place.name)
    }
    
    func checkLocationPermission() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func loadData() {
        let l = userDefaults.fetchList()
        if l.count == 0 {
            result?.didFetch(data: weatherData)
            return
        }
        
        service.weatherForList(cityList: l.owIDs())
    }
    
}

extension CityListInteractor: OWAPIWeatherDelegate {
    
    func didReceiveDataFor(city: CityWeatherData) {
        if weatherData.has(obj: city) {
            result?.didFetch(data: weatherData)
            gmsPlace = nil
            return
        }
        
        userDefaults.save(city: OWUserDefaultsCity(googleId: gmsPlace!.placeID, owId: String(city.id)))
        gmsPlace = nil
        
        weatherData.append(city)
        result?.didFetch(data: weatherData)
    }
    
    func didReceiveDataFor(cities: [CityWeatherData]) {
        weatherData = cities
        result?.didFetch(data: weatherData)
    }
    
    func didReceive(error: NSError) {
        print("did receive open weather error")
    }
    
}
