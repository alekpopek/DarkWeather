//
//  AppStyle.swift
//  DarkWeather
//
//  Created by Aleksander Popek on 01/12/2020.
//

import UIKit

class Style {

    /// Returns rounded system font with given size and weight
    /// - Parameters:
    ///   - size: font size
    ///   - weight: font weight
    /// - Returns: UIFont
    static func font(ofSize size:CGFloat, weight:UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            return UIFont(descriptor: descriptor, size: size)
        } else {
            return systemFont
        }
    }
}
