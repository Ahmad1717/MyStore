//
//  StringExtensions.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import Foundation

// localization
prefix operator &&

prefix func && (string: String) -> String {
    return NSLocalizedString(string, comment: "")
}
