//
//  AppConfig.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import Foundation

/// Used to store service specific vaues linek links or URLs
class Config {

   /// Returns API Url string
   static var APIBaseUrl: String {
       return "https://api.darksky.net/forecast/"
   }
}
