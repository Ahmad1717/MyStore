//
//  UIResponderExtensions.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension UIResponder: Identifiable {

    static var identifier: String {
        return "\(self)"
    }
}
