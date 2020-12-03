//
//  APIServiceProtocol.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import Foundation

/// The protocol used to define the specifications necessary for a APIService.
protocol APIServiceProtocol {

    /// API baseURL.
    var baseURL: String { get }

    /// The path that will be appended to API's base URL.
    var path: String { get }
}
