//
//  CityDetailViewController.swift
//  WeatherApp
//
//  Created by Tufyx on 18/06/2017.
//  Copyright © 2017 tufyx. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces

class CityDetailViewController: UIViewController, ReusableProtocol {
    
    var city: CityListItemViewModel?

    var presenter: CityDetailPresenterProtocol?
    
    @IBOutlet weak var forecastTable: UITableView!
    @IBOutlet var placeImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!

    var forecastData: [ForecastItemViewModel] = []

    override func viewDidLoad() {

        presenter?.city = city
        presenter?.view = self

        if let c = city {
            title = c.name

            forecastTable.dataSource = self

            temperatureLabel.text = "Temperature: \(c.temperature)°C"
            minTemperatureLabel.text = "Min: \(c.minTemperature)°C"
            maxTemperatureLabel.text = "Max: \(c.maxTemperature)°C"
            humidityLabel.text = "Humidty: \(c.humidty)%"
            pressureLabel.text = "Pressure: \(c.pressure) hPa"

            presenter?.fetchImageForPlace()
            presenter?.fetchForecast()
            return
        }
        
        title = "Unknown"
    }
    
}

extension CityDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ForecastCell.self)
        cell.data = forecastData[indexPath.row]
        return cell
    }

}

extension CityDetailViewController: CityDetailViewProtocol {

    var context: UIViewController {
        return self
    }

    func didReceive(data: [ForecastItemViewModel]) {
        forecastData = data
        forecastTable.reloadData()
    }

    func didReceiveError() {
        print("did receive error")
    }

    func didFetchPlaceImage(image: UIImage?) {
        placeImage.image = image!
    }

    func didGetErrorForImage() {
        print("error when fetching image for place")
    }

}
