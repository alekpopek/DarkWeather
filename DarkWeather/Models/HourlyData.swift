//
//  HourlyData.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import Foundation

struct HourlyData: Codable {
    let time: TimeInterval

    let summary: String

    let temperature: Double
    let pressure: Double
}
