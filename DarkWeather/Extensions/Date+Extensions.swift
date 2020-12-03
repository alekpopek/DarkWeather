//
//  Date+Extensions.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import Foundation

extension Date {
    var formattedDate: String {
        let calendar = Calendar(identifier: .iso8601)
        if calendar.isDateInToday(self) {
            return "TODAY"
        }
        if calendar.isDateInTomorrow(self) {
            return "TOMORROW"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self).uppercased()
    }
}
