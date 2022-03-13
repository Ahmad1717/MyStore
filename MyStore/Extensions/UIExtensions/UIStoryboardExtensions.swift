//
//  UIStoryboardExtensions.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

extension UIStoryboard {

    enum Storyboard: String {

        case main = "Main"
        case splash = "Splash"
        case products = "Products"
    }

    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
}
