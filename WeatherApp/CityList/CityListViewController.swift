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
    
    var presenter: CityListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure presenter
        presenter?.view = self
        presenter?.checkLocationPermission()
        presenter?.loadData()
        
        // configure UI
        tableView.tableFooterView = UIView()
        addCityButton.target = self
        addCityButton.action = #selector(didLaunchPlaceFinder)
    }
    
    func didLaunchPlaceFinder() {
        presenter?.showPlaceSelectionScreen()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = presenter?.getList()
        
        if list == nil || list!.isEmpty {
            showEmptyResult()
            return 0
        }
        
        tableView.backgroundView = UIView()
        return list!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: CityCell.self)
        cell.data = presenter?.getList()[indexPath.row]
        cell.delegate = self
        cell.backgroundColor = UIColor.green.withAlphaComponent(indexPath.row % 2 == 0 ? 0.4 : 0.2)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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

extension CityListViewController: CityCellClickDelegate {
    
    func didTapCellWith(data: CityListItemViewModel) {
        presenter?.showCityDetailScreenFor(city: data)
    }
    
}

extension CityListViewController: CityListViewProtocol {
    
    var context: UIViewController? {
        return self
    }
    
    func didReceiveData() {
        tableView.reloadData()
    }
    
}
