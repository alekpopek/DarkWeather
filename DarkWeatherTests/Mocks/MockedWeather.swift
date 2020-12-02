//
//  MockedWeather.swift
//  DarkWeatherTests
//
//  Created by Aleksander Popek on 02/12/2020.
//

import Foundation
@testable import DarkWeather

protocol MockedWeather {
    var mockedWeatherJSON:String { get }
    var mockedWeather:Weather { get }
}

extension MockedWeather {
    var mockedWeather:Weather {
        guard let jsonData:Data = mockedWeatherJSON.data(using: .utf8) else {
            fatalError("Cannot create data from string")
        }
        guard let weather = try? JSONDecoder().decode(Weather.self, from: jsonData) else {
            fatalError("Cannot decode json")
        }
        return weather
    }

    var mockedWeatherJSON:String {
        return """
        {
            "currently": {
                "time": 1606911279,
                "summary": "Dark Weather",
                "temperature": -1.0,
                "pressure": 1034.0
            },
            "hourly": {
                "summary": "Dark Weather",
                "data": [
                    {
                        "time": 1606910400,
                        "summary": "Darker Weather",
                        "temperature": -2.0,
                        "pressure": 1033.0
                    },
                    {
                        "time": 1606914000,
                        "summary": "Darkest Weather",
                        "temperature": -3.0,
                        "pressure": 1032.0
                    }
                ]
            },
            "daily": {
                "summary": "Dark Weather",
                "data": [
                    {
                        "time": 1606863600,
                        "summary": "Darker Weather",
                        "temperatureMin": -5.0,
                        "temperatureMax": -3.0,
                        "pressure": 1033.0
                    },
                    {
                        "time": 1606950000,
                        "summary": "Darkest Weather",
                        "temperatureMin": -4.0,
                        "temperatureMax": -2.0,
                        "pressure": 1031.0
                    }
                ]
            }
        }
    """
    }
}
