//
//  UIColorExtensions.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

prefix operator **

// Restricted scope of ** operator to this file only.
prefix func ** (name: String) -> UIColor {
    return UIColor(named: name) ?? UIColor.white
}

// Background
extension UIColor {
    static let navigationColor = **"NavigationColor"
}
