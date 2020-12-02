//
//  URL+Extensions.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import Foundation

extension URL {
    /// Initialize URL from `APIServiceProtocol`.
    init<T: APIServiceProtocol>(target: T) {
        if target.path.isEmpty {
            guard let url = URL(string: target.baseURL) else {
                fatalError("You didn't set baseURL properly")
            }
            self = url

        } else {
            guard let url = URL(string: target.baseURL + target.path) else {
                fatalError("You didn't set baseURL properly")
            }
            self = url
        }
    }
}
