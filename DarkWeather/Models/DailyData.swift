//
//  DailyData.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import Foundation

struct DailyData: Codable {
    let time:TimeInterval
    let summary:String

    let temperatureMin:Double
    let temperatureMax:Double

    let pressure:Double
    
    var date:Date {
        return Date(timeIntervalSince1970: time)
    }
}
