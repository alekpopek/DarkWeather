//
//  DailyForecast.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import Foundation

struct DailyForecast: Codable {
    let summary:String
    let data:[DailyData]
}
