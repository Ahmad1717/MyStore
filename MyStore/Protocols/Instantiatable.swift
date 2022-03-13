//
//  Instantiatable.swift
//  MyStore
//
//  Created by Ahmad Jabri on 13/03/2022.
//

import UIKit

protocol Instantiatable {
    static func instantiate(from storyboardIdentifier: UIStoryboard.Storyboard) -> Self
}

extension UIViewController: Instantiatable { }

extension Instantiatable where Self: UIViewController {

    static func instantiate(from storyboardIdentifier: UIStoryboard.Storyboard = .main) -> Self {

        guard let viewController = UIStoryboard(storyboard: storyboardIdentifier).instantiateViewController(withIdentifier: identifier) as? Self else {
            return Self()
        }
        return viewController
    }
}
