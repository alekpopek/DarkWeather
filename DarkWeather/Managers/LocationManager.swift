//
//  LocationManager.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {

    static let sharedInstance:LocationManager = { LocationManager() }()
    
    let locationManager = CLLocationManager()
    
    var completion:((CLLocation?) -> Void)?

    var locationServicesEnabled:Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
    /// Used to get device location
    /// - Parameter completion: Callback returning location
    func getUserLocation(completion: @escaping (CLLocation?) -> Void) {
        self.completion = completion
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        if CLLocationManager.locationServicesEnabled() {
            startUpdates()
        }
    }
    
    /// Used to get city name based on device location
    /// - Parameters:
    ///   - location: device location
    ///   - completion: Callback returning city name
    func getCityName(forLocation location: CLLocation, _ completion: @escaping (String) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let city = placemarks?[0].locality {
                completion(city)
            } else {
                completion("")
            }
        }
    }
    
    fileprivate func startUpdates() {
        locationManager.startUpdatingLocation()
    }
    
    fileprivate func stopUpdates() {
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        stopUpdates()
        if let location = locations.first {
            completion?(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?(nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status.authorized {
            startUpdates()
        } else if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            completion?(nil)
        }
    }
}

// MARK: - CLAuthorizationStatus

extension CLAuthorizationStatus {
    var authorized:Bool {
        switch self {
        case .authorizedAlways,.authorizedWhenInUse:
            return true
        default:
            return false
        }
    }
}
