//
//  APIService.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import Foundation

enum APIService: APIServiceProtocol {
    case getWeather(
        latitude: Double,
        longitude: Double
    )

    /// API baseURL.
    var baseURL: String {
        switch self {
        case .getWeather:
            return Config.APIBaseUrl + Secrets.apiKey
        }
    }

    /// The path that will be appended to API's base URL.
    var path: String {
        switch self {
        case .getWeather(let latitude, let longitude):
            return "/\(latitude),\(longitude)"
        }
    }
}
