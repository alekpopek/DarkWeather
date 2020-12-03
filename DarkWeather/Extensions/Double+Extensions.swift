//
//  Double+Extensions.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import Foundation

extension Double {
    var formattedTemperature: String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1

        if let string = formatter.string(from: self as NSNumber) {
            return string + "°"
        }
        return ""
    }

    var toCelsius: Double {
        return (self - 32) * 5 / 9
    }
}
