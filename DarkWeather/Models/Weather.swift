//
//  Weather.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import Foundation

struct Weather: Codable {
    let current:HourlyData
    let hourly:HourlyForecast
    let daily:DailyForecast
    
    private enum CodingKeys: String, CodingKey {
        case current = "currently"
        case hourly = "hourly"
        case daily = "daily"
    }
}
