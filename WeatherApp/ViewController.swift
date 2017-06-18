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

class ViewController: UIViewController {

    @IBOutlet weak var requestButton: UIButton!
    
    var weatherService: OpenWeatherAPIProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    func didTapButton() {
        requestButton.isEnabled = false
        weatherService?.delegate = self
        weatherService?.weatherForCity(city: "London", inCountry: "uk")
    }

}

extension ViewController: OpenWeatherAPIDelegate {
    
    func didReceiveDataFor(city: CityWeatherData) {
        requestButton.isEnabled = true
        print("did receive open weather data for \(city.name)")
        print(city)
    }
    
    func didReceive(error: NSError) {
        requestButton.isEnabled = true
        print("did receive open weather error")
    }
    
}
