//
//  Item.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 02/12/2020.
//

import Foundation

/// Used as TableView datasource
struct Item {
    var type: ItemType
    var title: String
    var subtitle: String
    var temperatureMin: Double?
    var temperatureMax: Double?
}
