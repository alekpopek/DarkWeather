//
//  ItemType.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 02/12/2020.
//

import UIKit

enum ItemType {
    case temperature
    case daily
    case error

    var height: CGFloat {
        switch self {
        case .temperature,
             .error:
            return 250.0
        case .daily:
            return 60.0
        }
    }
}
