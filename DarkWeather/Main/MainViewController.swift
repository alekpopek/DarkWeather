//
//  MainViewController.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import UIKit

class MainViewController: UIViewController {
    
    let tableView:UITableView = UITableView()
    
    var viewModel:MainViewModel!
    
    override func loadView() {
        super.loadView()
     
        view.backgroundColor = UIColor.systemBackground
        
        setupNavigationController()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
        LocationManager.sharedInstance.getUserLocation { (location) in
            /// Store location and load weather data
            self.viewModel.location = location
            self.fetchData()
            
            /// Display city name as navigation title
            if let location = location {
                LocationManager.sharedInstance.getCityName(forLocation: location) { (city) in
                    self.title = city
                }
            }
        }
    }

    private func fetchData() {
        viewModel.loadWeather { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.register(TemperatureTableViewCell.self)
        tableView.register(DailyTableViewCell.self)

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50.0
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        switch item.type {
        case .temperature:
            let cell = tableView.dequeueCell(TemperatureTableViewCell.self, forIndexPath: indexPath)
            cell.temperatureLabel.text = item.title
            cell.summaryLabel.text = item.subtitle
            return cell
            
        case .daily:
            let cell = tableView.dequeueCell(DailyTableViewCell.self, forIndexPath: indexPath)
            cell.titleLabel.text = item.title
            cell.subtitleLabel.text = item.subtitle
            cell.setTemperature(min: item.temperatureMin, max: item.temperatureMax)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = viewModel.items[indexPath.row]
        return item.type.height
    }
}
