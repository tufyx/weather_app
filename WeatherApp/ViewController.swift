//
//  ViewController.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var requestButton: UIButton!
    
    var weatherService: OpenWeatherAPIProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    func didTapButton() {
        weatherService?.delegate = self
        weatherService?.weatherForCity(city: "London", inCountry: "uk")
    }

}

extension ViewController: OpenWeatherAPIDelegate {
    
    func didReceiveData(response: Any?) {
        print("did receive open weather data")
        print("response > \(String(describing: response))")
    }
    
    func didReceive(error: NSError) {
        print("did receive open weather error")
    }
    
}
