//
//  MainViewModel.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import Foundation
import CoreLocation

class MainViewModel {
    
    private let apiClient:APIClientProtocol
    
    /// Populate items array everytime weather object is set
    var weather:Weather? {
        didSet {
            items.removeAll()
            if let weather = weather {
                items.append(
                    Item(
                        type: .temperature,
                        title: weather.current.temperature.toCelsius.formattedTemperature,
                        subtitle: weather.current.summary,
                        temperatureMin: nil,
                        temperatureMax: nil
                    )
                )
                for data in weather.daily.data {
                    items.append(
                        Item(
                            type: .daily,
                            title: data.date.formattedDate,
                            subtitle: data.summary,
                            temperatureMin: data.temperatureMin,
                            temperatureMax: data.temperatureMax
                        )
                    )
                }
            }
        }
    }
    
    /// Tableview data source
    var items:[Item] = []

    /// Returns true if API request is active
    private var isLoading:Bool = false

    /// User location handling
    private var longitude:Double?
    private var latitude:Double?

    var location:CLLocation? {
        didSet {
            longitude = location?.coordinate.longitude
            latitude = location?.coordinate.latitude
        }
    }
    
    var error: APIError?
        
    init(apiClient:APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
}

// MARK: - API calls

extension MainViewModel {
    /// Used to load weather forecast from darkSky API
    /// - Parameter completion: completion handler
    func loadWeather(_ completion: @escaping () -> Void) {
        /// Check if location variables are set and request is not active
        guard !isLoading, let latitude = latitude, let longitude = longitude else {
            completion()
            return
        }
        /// Fetch weather forecast for given location
        isLoading = true
        apiClient.request(
            target: .getWeather(
                latitude: latitude,
                longitude: longitude
            ),
            type: Weather.self
        ) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.weather = response
            case .failure(let error):
                self?.error = error
            }
            self?.isLoading = false
            completion()
        }
    }
}
